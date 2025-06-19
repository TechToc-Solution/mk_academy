import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

part 'download_manager_state.dart';

/// Represents a single download keyed by "$videoId-$quality".
// ignore: must_be_immutable
class DownloadTaskInfo {
  final String taskId;
  final String url;
  final String fileName;
  final String filePath; // Added file path
  final DownloadTaskStatus status;
  final int progress;

  DownloadTaskInfo({
    required this.taskId,
    required this.url,
    required this.fileName,
    required this.filePath, // Added
    required this.status,
    this.progress = 0,
  });

  DownloadTaskInfo copyWith({
    String? taskId,
    DownloadTaskStatus? status,
    int? progress,
  }) {
    return DownloadTaskInfo(
      taskId: taskId ?? this.taskId,
      url: url,
      fileName: fileName,
      filePath: filePath, // Added
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }
}

@pragma('vm:entry-point')
class DownloadManagerCubit extends Cubit<DownloadManagerState> {
  final ReceivePort _port = ReceivePort();

  DownloadManagerCubit() : super(DownloadInitial()) {
    _bindBackgroundIsolate();
    _initDownloader();
    _port.listen((data) {
      final String id = data[0];
      final int statusValue = data[1];
      final int progress = data[2];
      final DownloadTaskStatus status = DownloadTaskStatus.values[statusValue];
      _updateTaskProgress(id, status, progress);
    });
  }

  Future<void> _initDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
      debug: false,
      ignoreSsl: false,
    );
    FlutterDownloader.registerCallback(downloadCallback);

    // Load all existing tasks
    final tasks = await FlutterDownloader.loadTasks();
    if (tasks != null) {
      final updatedTasks = Map<String, DownloadTaskInfo>.from(state.tasks);

      for (final task in tasks) {
        // Skip tasks without filenames
        if (task.filename == null) continue;

        final key = task.filename!.replaceFirst('.mp4', '');
        final filePath = '${task.savedDir}/${task.filename}';
        final file = File(filePath);

        // Handle all completed downloads
        if (task.status == DownloadTaskStatus.complete) {
          updatedTasks[key] = DownloadTaskInfo(
            taskId: task.taskId,
            url: task.url,
            fileName: task.filename!,
            filePath: filePath,
            status: DownloadTaskStatus.complete,
            progress: 100,
          );
        }
        // Handle failed downloads with existing files
        else if (task.status == DownloadTaskStatus.failed &&
            await file.exists() &&
            file.lengthSync() > 0) {
          await FlutterDownloader.remove(
            taskId: task.taskId,
            shouldDeleteContent: false,
          );

          updatedTasks[key] = DownloadTaskInfo(
            taskId: task.taskId,
            url: task.url,
            fileName: task.filename!,
            filePath: filePath,
            status: DownloadTaskStatus.complete,
            progress: 100,
          );
        }
        // Handle other active tasks
        else {
          updatedTasks[key] = DownloadTaskInfo(
            taskId: task.taskId,
            url: task.url,
            fileName: task.filename!,
            filePath: filePath,
            status: task.status,
            progress: task.progress,
          );
        }
      }

      // Only emit update if we found tasks
      if (updatedTasks.isNotEmpty) {
        emit(DownloadUpdated(tasks: updatedTasks));
      }
    }
  }

  void _bindBackgroundIsolate() {
    if (IsolateNameServer.lookupPortByName('downloader_send_port') != null) {
      IsolateNameServer.removePortNameMapping('downloader_send_port');
    }
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  Future<void> addDownload(String videoId, String quality, String url) async {
    final dir = (await getApplicationSupportDirectory()).path;
    final fileName = '$videoId-$quality.mp4';
    final filePath = '$dir/$fileName'; // Calculate full path

    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: dir,
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: false,
      saveInPublicStorage: false,
    );

    if (taskId == null) return;

    final key = '$videoId-$quality';
    final task = DownloadTaskInfo(
      taskId: taskId,
      url: url,
      fileName: fileName,
      filePath: filePath, // Added
      status: DownloadTaskStatus.enqueued,
    );

    final updatedTasks = Map<String, DownloadTaskInfo>.from(state.tasks)
      ..[key] = task;
    emit(DownloadUpdated(tasks: updatedTasks)); // Use new state
  }

  Future<void> pauseDownload(String taskId) async {
    await FlutterDownloader.pause(taskId: taskId);
    _updateTaskStatus(taskId, DownloadTaskStatus.paused);
  }

  Future<void> resumeDownload(String taskId) async {
    final newTaskId = await FlutterDownloader.resume(taskId: taskId);
    if (newTaskId == null) return;

    final key = state.tasks.entries
        .firstWhere(
          (e) => e.value.taskId == taskId,
          orElse: () => throw StateError('Task not found'),
        )
        .key;

    final task = state.tasks[key]!
        .copyWith(taskId: newTaskId, status: DownloadTaskStatus.running);

    final updatedTasks = Map<String, DownloadTaskInfo>.from(state.tasks)
      ..[key] = task;
    emit(DownloadUpdated(tasks: updatedTasks));
  }

  Future<void> cancelDownload(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
    _updateTaskStatus(taskId, DownloadTaskStatus.canceled);
  }

  void _updateTaskProgress(
      String taskId, DownloadTaskStatus status, int progress) {
    try {
      final key =
          state.tasks.entries.firstWhere((e) => e.value.taskId == taskId).key;
      final task = state.tasks[key]!;
      final file = File(task.filePath);

      // Handle HTTP 416 error by marking as complete
      if (status == DownloadTaskStatus.failed &&
          file.existsSync() &&
          file.lengthSync() > 0) {
        final updatedTask =
            task.copyWith(status: DownloadTaskStatus.complete, progress: 100);
        final updatedTasks = Map<String, DownloadTaskInfo>.from(state.tasks)
          ..[key] = updatedTask;
        emit(DownloadUpdated(tasks: updatedTasks));
        return;
      }

      // Normal progress update
      final updatedTask = task.copyWith(status: status, progress: progress);
      final updatedTasks = Map<String, DownloadTaskInfo>.from(state.tasks)
        ..[key] = updatedTask;
      emit(DownloadUpdated(tasks: updatedTasks));
    } catch (_) {}
  }

  void _updateTaskStatus(String taskId, DownloadTaskStatus status) {
    try {
      final key =
          state.tasks.entries.firstWhere((e) => e.value.taskId == taskId).key;
      final task = state.tasks[key]!.copyWith(status: status);
      final updatedTasks = Map<String, DownloadTaskInfo>.from(state.tasks)
        ..[key] = task;
      emit(DownloadUpdated(tasks: updatedTasks)); // Use new state
    } catch (_) {}
  }

  @override
  Future<void> close() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    return super.close();
  }
}
