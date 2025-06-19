import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/errors/failuer.dart';

import '../../../utils/enums.dart';

class DownloadResult {
  final DownloadStatus status;
  final String? filePath;
  DownloadResult({required this.status, this.filePath});
}

abstract class DownloadHandlerRepo {
  Future<Either<Failure, DownloadResult>> downloadFile({
    required String url,
    required String fileName,
    Function(double progress)? onProgress,
  });
  Future<String> getFilePath({required String fileName, required int id});
}
