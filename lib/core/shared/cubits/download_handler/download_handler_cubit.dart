import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/repos/download_handler/download_handler_repo.dart';
import '../../../utils/enums.dart';
import 'download_handler_state.dart';

class DownloadCubit extends Cubit<DownloadHandlerState> {
  final DownloadHandlerRepo repo;

  DownloadCubit({required this.repo}) : super(DownloadHandlerInitial());

  Future<void> startDownload(
      {required String url, required String fileName, required int id}) async {
    emit(DownloadHandlerLoding(id: id));
    final result = await repo.downloadFile(url: url, fileName: fileName);
    result.fold(
        (failure) =>
            emit(DownloadHandlerError(errorMsg: failure.message, id: id)),
        (downloadResult) {
      if (downloadResult.status == DownloadStatus.completed) {
        emit(DownloadHandlerSuccess(filePath: downloadResult.filePath, id: id));
      } else if (downloadResult.status == DownloadStatus.permissionDenied) {
        emit(DownloadHandlerDenied(id: id));
      }
    });
  }
}
