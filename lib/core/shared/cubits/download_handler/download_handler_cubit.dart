import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/repos/download_handler/download_handler_repo.dart';
import '../../../utils/enums.dart';

class DownloadCubit extends Cubit<DownloadStatus> {
  final DownloadHandlerRepo repo;

  DownloadCubit({required this.repo}) : super(DownloadStatus.initial);

  String? _downloadedFilePath;
  String? get downloadedFilePath => _downloadedFilePath;

  Future<void> startDownload(
      {required String url, required String fileName}) async {
    emit(DownloadStatus.downloading);
    final result = await repo.downloadFile(url: url, fileName: fileName);
    if (result.status == DownloadStatus.completed) {
      _downloadedFilePath = result.filePath;
    }
    emit(result.status);
  }
}
