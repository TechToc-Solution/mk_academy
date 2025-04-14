import '../../../utils/enums.dart';

class DownloadResult {
  final DownloadStatus status;
  final String? filePath;
  DownloadResult({required this.status, this.filePath});
}

abstract class DownloadHandlerRepo {
  Future<DownloadResult> downloadFile({
    required String url,
    required String fileName,
  });
}
