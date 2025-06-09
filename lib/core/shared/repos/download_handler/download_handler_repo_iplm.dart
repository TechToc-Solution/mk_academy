import 'dart:developer';
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
  }) async {
    try {
      final cleanFileName = '$fileName.pdf';

      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        final sdkInt = androidInfo.version.sdkInt;

        if (sdkInt >= 30) {
          var managePermission = await Permission.manageExternalStorage.status;
          if (!managePermission.isGranted) {
            managePermission = await Permission.manageExternalStorage.request();
            if (!managePermission.isGranted) {
              await openAppSettings();
              return right(
                  DownloadResult(status: DownloadStatus.permissionDenied));
            }
          }
        } else {
          // Android 10 and below
          var storagePermission = await Permission.storage.status;
          if (!storagePermission.isGranted) {
            storagePermission = await Permission.storage.request();
            if (!storagePermission.isGranted) {
              await openAppSettings();
              return right(
                  DownloadResult(status: DownloadStatus.permissionDenied));
            }
          }
        }
      }

      // Get correct directory
      Directory dir;
      if (Platform.isAndroid) {
        final publicDownloadsPath =
            await ExternalPath.getExternalStoragePublicDirectory(
                ExternalPath.DIRECTORY_DOWNLOAD);
        final appFolderPath =
            path.join(publicDownloadsPath, 'mk_academy_downloads');
        dir = Directory(appFolderPath);
        if (!await dir.exists()) await dir.create(recursive: true);
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      final filePath = path.join(dir.path, cleanFileName);
      log("Downloading to: $filePath");

      await dio.download(
        url,
        filePath,
        options: Options(headers: {
          'Authorization': 'Bearer ${CacheHelper.getData(key: "token")}',
        }),
      );

      final fileExists = await File(filePath).exists();
      return right(fileExists
          ? DownloadResult(status: DownloadStatus.completed, filePath: filePath)
          : DownloadResult(status: DownloadStatus.failed));
    } catch (e) {
      log("Download File Error: $e");
      return left(ErrorHandler.handle(e));
    }
  }
}
