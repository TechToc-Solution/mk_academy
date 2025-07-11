// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';
import 'package:open_file/open_file.dart';

import '../../../../../core/shared/cubits/download_handler/download_handler_cubit.dart';
import '../../../../../core/shared/cubits/download_handler/download_handler_state.dart';
import '../../../../../core/utils/functions.dart';
import 'custom_circular_icon.dart';
import 'download_success_snak_bar.dart';

class DownloadFileBlocConsumer extends StatelessWidget {
  const DownloadFileBlocConsumer({
    super.key,
    required this.video,
  });
  void openFile(BuildContext context, String filePath) {
    // Use a package like `open_file` to open the file
    OpenFile.open(filePath).then((result) {
      if (result.type == ResultType.noAppToOpen) {
        messages(context, "error".tr(context), Colors.red);
      }
    });
  }

  final VideoDataModel video;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadCubit, DownloadHandlerState>(
        builder: (context, state) {
      if (state is DownloadHandlerSuccess && state.id == video.id) {
        return CustomCircularIcon(
            icon: Icons.visibility,
            onTap: () {
              openFile(context, state.filePath!);
            },
            downloaded: true);
      } else {
        return CustomCircularIcon(
          showProgress:
              state is DownloadHandlerProgress && state.id == video.id,
          progress: state is DownloadHandlerProgress ? state.progress : 0.0,
          icon: Icons.download_for_offline_rounded,
          onTap: () {
            if (video.file != null) {
              if (state is! DownloadHandlerProgress) {
                context.read<DownloadCubit>().startDownload(
                    url: video.file!, fileName: video.name!, id: video.id!);
              }
            } else {
              messages(context, "video_not_available_message".tr(context),
                  Colors.grey);
            }
          },
        );
      }
    }, listener: (BuildContext context, DownloadHandlerState state) {
      if (state is DownloadHandlerSuccess &&
          !state.downloaded &&
          state.id == video.id) {
        DownloadSnackBar.show(context: context, filePath: state.filePath!);
      } else if (state is DownloadHandlerError) {
        messages(context, state.errorMsg, Colors.red);
      } else if (state is DownloadHandlerDenied) {
        messages(context, "permission_denied_msg".tr(context), Colors.red);
      }
    });
  }
}
