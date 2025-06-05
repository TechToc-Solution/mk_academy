import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';

import '../../../../../../core/shared/cubits/download_handler/download_handler_cubit.dart';
import '../../../../../../core/shared/cubits/download_handler/download_handler_state.dart';
import '../../../../../../core/utils/functions.dart';
import 'custom_circular_icon.dart';
import 'download_success_snak_bar.dart';

class DownloadFileBlocConsumer extends StatelessWidget {
  const DownloadFileBlocConsumer({
    super.key,
    required this.video,
  });

  final VideoDataModel video;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadCubit, DownloadHandlerState>(
      builder: (context, state) {
        return CustomCircularIcon(
          showProgress: state is DownloadHandlerLoding && state.id == video.id,
          icon: Icons.download_for_offline_rounded,
          onTap: () {
            if (video.file != null) {
              context.read<DownloadCubit>().startDownload(
                  url: video.file!, fileName: video.name!, id: video.id!);
            } else {
              messages(context, "video_not_available_message".tr(context),
                  Colors.grey);
            }
          },
        );
      },
      listener: (BuildContext context, DownloadHandlerState state) {
        if (state is DownloadHandlerSuccess && state.filePath != null) {
          if (state.id == video.id) {
            DownloadSnackBar.show(context: context, filePath: state.filePath!);
          }
        } else if (state is DownloadHandlerError) {
          if (state.id == video.id) {
            messages(context, state.errorMsg, Colors.red);
          }
        } else if (state is DownloadHandlerDenied) {
          if (state.id == video.id) {
            messages(context, "permission_denied_msg".tr(context), Colors.red);
          }
        }
      },
    );
  }
}
