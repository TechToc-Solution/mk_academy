import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/manager/download_manager_cubit.dart';

typedef OnPlayOfflineCallback = void Function(String localFilePath);

class QualityTile extends StatefulWidget {
  const QualityTile({
    super.key,
    required this.videoId,
    required this.quality,
    required this.onPlayOffline,
  });

  final String videoId;
  final DownloadUrls quality;
  final OnPlayOfflineCallback onPlayOffline;

  @override
  State<QualityTile> createState() => _QualityTileState();
}

class _QualityTileState extends State<QualityTile> {
  DownloadTaskStatus? _lastTaskStatus;

  @override
  Widget build(BuildContext context) {
    final key = '${widget.videoId}-${widget.quality.resolution}';

    return BlocListener<DownloadManagerCubit, DownloadManagerState>(
      listener: (context, state) {
        final task = state.tasks[key];
        if (task == null || task.status == _lastTaskStatus) return;

        _lastTaskStatus = task.status;

        if (task.status == DownloadTaskStatus.complete) {
          messages(
              context,
              "${"video_downloaded".tr(context)} ${widget.quality.resolution}",
              AppColors.primaryColors);
        } else if (task.status == DownloadTaskStatus.failed) {
          showCustomDialog(
            context: context,
            icon: Icons.download,
            title: "video_error_download".tr(context),
            description: "",
            primaryButtonText: "ok".tr(context),
            onPrimaryAction: () => Navigator.pop(context),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: boxDecoration(),
        child: ListTile(
          leading: const Icon(Icons.video_library),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text(
            "${"quality".tr(context)}: ${widget.quality.resolution}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: BlocBuilder<DownloadManagerCubit, DownloadManagerState>(
            buildWhen: (previous, current) {
              final prev = previous.tasks[key];
              final curr = current.tasks[key];
              // if neither existed before, or both are null, skip
              if (prev == null && curr == null) return false;
              // rebuild if status or progress differs
              return prev?.status != curr?.status ||
                  prev?.progress != curr?.progress;
            },
            builder: (context, state) {
              final task = state.tasks[key];
              final cubit = context.read<DownloadManagerCubit>();

              if (task == null) {
                return _btnDownload(cubit);
              }
              switch (task.status) {
                case DownloadTaskStatus.running:
                case DownloadTaskStatus.enqueued:
                  return _btnPause(task, cubit);
                case DownloadTaskStatus.paused:
                  return _btnResume(task, cubit);
                case DownloadTaskStatus.complete:
                  return _btnPlay(task);
                case DownloadTaskStatus.failed: // ADD FAILED CASE
                case DownloadTaskStatus.canceled: // ADD CANCELED CASE
                  return _btnRetry(cubit);
                default: // Failed/canceled
                  return _btnRetry(cubit);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _btnDownload(DownloadManagerCubit cubit) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColors,
      ),
      child: IconButton(
        icon: Icon(Icons.download_for_offline, color: Colors.white),
        onPressed: () => showCustomDialog(
          icon: Icons.warning,
          context: context,
          title: '',
          description: "download_warning".tr(context),
          primaryButtonText: "yes".tr(context),
          onPrimaryAction: () {
            cubit.addDownload(widget.videoId, widget.quality.resolution!,
                widget.quality.url!);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _btnPause(DownloadTaskInfo task, DownloadManagerCubit cubit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Text(
            '${task.progress}%',
            key: ValueKey(task.progress),
            style: TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(width: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: task.progress / 100,
              ),
              duration: Duration(milliseconds: 300),
              builder: (context, value, _) {
                return SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: 3,
                    backgroundColor: Colors.grey.shade200,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.secColors),
                  ),
                );
              },
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColors,
              ),
              child: IconButton(
                icon: Icon(Icons.pause, color: Colors.white, size: 20),
                onPressed: () => cubit.pauseDownload(task.taskId),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _btnResume(DownloadTaskInfo task, DownloadManagerCubit cubit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Text(
            '${task.progress}%',
            key: ValueKey(task.progress),
            style: TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(width: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: task.progress / 100,
              ),
              duration: Duration(milliseconds: 300),
              builder: (context, value, _) {
                return SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: 3,
                    backgroundColor: Colors.grey.shade200,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.secColors),
                  ),
                );
              },
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColors,
              ),
              child: IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.white, size: 20),
                onPressed: () => cubit.resumeDownload(task.taskId),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _btnPlay(DownloadTaskInfo task) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColors,
      ),
      child: IconButton(
        icon: Icon(Icons.play_circle_fill, color: Colors.white, size: 20),
        onPressed: () => widget.onPlayOffline(task.filePath),
      ),
    );
  }

  Widget _btnRetry(DownloadManagerCubit cubit) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColors,
      ),
      child: IconButton(
        icon: Icon(Icons.refresh, color: Colors.white, size: 20),
        onPressed: () => showCustomDialog(
          icon: Icons.warning,
          context: context,
          title: '',
          description: "download_warning".tr(context),
          primaryButtonText: "yes".tr(context),
          onPrimaryAction: () {
            cubit.addDownload(widget.videoId, widget.quality.resolution!,
                widget.quality.url!);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
