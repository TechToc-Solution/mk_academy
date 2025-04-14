import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:external_path/external_path.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:mk_academy/core/errors/error_handler.dart';
import 'package:permission_handler/permission_handler.dart';

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
      // 1. Handle filename with PDF extension
      final cleanFileName = '$fileName.pdf';

      // 2. Retrieve correct directory based on platform:
      Directory dir;
      if (Platform.isAndroid) {
        // Use external_path on Android to retrieve public Downloads folder.
        final publicDownloadsPath =
            await ExternalPath.getExternalStoragePublicDirectory(
                ExternalPath.DIRECTORY_DOWNLOAD);
        //create a sub-folder for the app.
        final appFolderPath =
            path.join(publicDownloadsPath, 'mk_academy_downloads');
        dir = Directory(appFolderPath);
        if (!await dir.exists()) await dir.create(recursive: true);
      } else {
        // For iOS, fall back to the application documents directory.
        dir = await getApplicationDocumentsDirectory();
      }

      // 3. Handle Android permissions (if applicable)
      final status = await Permission.storage.request();
      if (Platform.isAndroid && status.isDenied) {
        return right(DownloadResult(status: DownloadStatus.permissionDenied));
      }

      // 4. Construct the file path and perform the download.
      final filePath = path.join(dir.path, cleanFileName);
      log("file path is: $filePath");
      await dio.download(url, filePath);

      // 5. Verify file exists and return the appropriate DownloadResult.
      return right(await File(filePath).exists()
          ? DownloadResult(status: DownloadStatus.completed, filePath: filePath)
          : DownloadResult(status: DownloadStatus.failed));
    } catch (e) {
      log("Downold File Error: $e");
      return left(ErrorHandler.handle(e));
    }
  }
}
