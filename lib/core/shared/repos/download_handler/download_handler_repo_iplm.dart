import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/enums.dart';
import 'download_handler_repo.dart';

class DownloadRepositoryImpl implements DownloadHandlerRepo {
  final Dio dio;

  DownloadRepositoryImpl(this.dio);

  @override
  Future<DownloadResult> downloadFile({
    required String url,
    required String fileName,
  }) async {
    try {
      // 1. Handle filename with PDF extension
      final cleanFileName = '$fileName.pdf';

      // 2. Get directory

      final Directory dir = Platform.isAndroid
          ? (await getExternalStorageDirectory())!
          : await getApplicationDocumentsDirectory();

      // 3. Create directory if not exists
      if (!await dir.exists()) await dir.create(recursive: true);

      // 4. Handle Android permissions
      if (Platform.isAndroid && !await _requestAndroidPermissions()) {
        return DownloadResult(status: DownloadStatus.permissionDenied);
      }

      // 5. Perform download
      final filePath = path.join(dir.path, cleanFileName);
      await dio.download(url, filePath);
      log(filePath);
      // 6. Verify file exists
      return await File(filePath).exists()
          ? DownloadResult(status: DownloadStatus.completed, filePath: filePath)
          : DownloadResult(status: DownloadStatus.permissionDenied);
    } catch (e) {
      log('Download error: $e');
      return DownloadResult(status: DownloadStatus.permissionDenied);
    }
  }

  // String _sanitizeFileName(String name) {
  //   return name.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
  // }

  Future<bool> _requestAndroidPermissions() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }
}
