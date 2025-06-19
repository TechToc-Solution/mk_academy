import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:mk_academy/core/errors/error_handler.dart';

import '../../../errors/failuer.dart';
import '../../../utils/enums.dart';
import 'download_handler_repo.dart';

class DownloadRepositoryImpl implements DownloadHandlerRepo {
  final Dio dio;

  DownloadRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, DownloadResult>> downloadFile({
    required String url,
    required String fileName,
    Function(double progress)? onProgress,
  }) async {
    try {
      final cleanFileName = '$fileName.pdf';
      Directory targetDir;

      // Platform-specific directory handling
      if (Platform.isAndroid) {
        // Android permission handling
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;

        if (sdkInt >= 30) {
          // Android 11+
          if (!await Permission.manageExternalStorage.isGranted) {
            final status = await Permission.manageExternalStorage.request();
            if (!status.isGranted) {
              return right(
                  DownloadResult(status: DownloadStatus.permissionDenied));
            }
          }
        } else {
          // Android 10 and below
          if (!await Permission.storage.isGranted) {
            final status = await Permission.storage.request();
            if (!status.isGranted) {
              return right(
                  DownloadResult(status: DownloadStatus.permissionDenied));
            }
          }
        }
        targetDir = Directory('/storage/emulated/0/Download');
      } else {
        // iOS and other platforms
        targetDir = await getApplicationDocumentsDirectory();
      }

      // Create app-specific subdirectory
      final appDir =
          Directory(path.join(targetDir.path, 'mk_academy_downloads'));
      if (!await appDir.exists()) await appDir.create(recursive: true);

      final filePath = path.join(appDir.path, cleanFileName);

      await dio.download(
        url,
        filePath,
        deleteOnError: true,
        onReceiveProgress: (received, total) {
          if (total != -1 && onProgress != null) {
            onProgress(received / total);
          }
        },
        options: Options(headers: {
          'Authorization': 'Bearer ${CacheHelper.getData(key: "token")}',
        }),
      );

      final fileExists = await File(filePath).exists();
      return right(fileExists
          ? DownloadResult(status: DownloadStatus.completed, filePath: filePath)
          : DownloadResult(status: DownloadStatus.failed));
    } catch (e) {
      // log("Download File Error: $e");
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<String> getFilePath(
      {required String fileName, required int id}) async {
    final cleanFileName = '$fileName.pdf';
    Directory dir;

    if (Platform.isAndroid) {
      final publicDownloadsPath =
          await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOWNLOAD);
      final appFolderPath =
          path.join(publicDownloadsPath, 'mk_academy_downloads');
      dir = Directory(appFolderPath);
    } else {
      dir = await getApplicationDocumentsDirectory();
    }

    return path.join(dir.path, cleanFileName);
  }
}
