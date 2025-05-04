import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../../core/shared/cubits/download_handler/download_handler_cubit.dart';
import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/functions.dart';
import '../../../../../show_video/presentation/views/show_video.dart';
import '../../../../data/model/video_model.dart';
import 'custom_circular_icon.dart';
import 'download_file_bloc_consumer.dart';
import 'video_info_section.dart';
import 'video_thumbnail_image.dart';

class PlayListBody extends StatelessWidget {
  const PlayListBody({super.key, required this.videos});
  final List<Video> videos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            if (videos[index].filePath != null) {
              _handleVideoPress(
                  context, index, videos[index].filePath!, videos[index].name!);
            } else {
              Navigator.of(context).push(goRoute(
                x: WebViewScreen(video: videos[index]),
              ));
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primaryColors, width: 1),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    CustomCircularIcon(
                      icon: Icons.play_arrow_rounded,
                      onTap: () {
                        if (videos[index].filePath != null) {
                          _handleVideoPress(context, index,
                              videos[index].filePath!, videos[index].name!);
                        } else {
                          Navigator.of(context).push(goRoute(
                            x: WebViewScreen(video: videos[index]),
                          ));
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DownloadFileBlocConsumer(video: videos[index]),
                  ],
                ),
                const SizedBox(width: 12),
                VideoInfoSection(video: videos[index]),
                const SizedBox(width: 12),
                VideoThumbnailImage(video: videos[index]),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleDownload(
      BuildContext context, String url, String fileName, int id) {
    final cubit = context.read<DownloadCubit>();

    cubit.startDownload(url: url, fileName: fileName, id: id);
  }

  void _handleVideoPress(
      BuildContext context, int index, String url, String fileName) {
    showCustomDialog(
      context: context,
      title: 'alert'.tr(context),
      description: 'download_before_watch'.tr(context),
      primaryButtonText: 'download'.tr(context),
      secondaryButtonText: 'watch'.tr(context),
      primaryButtonColor: AppColors.primaryColors,
      icon: Icons.warning_amber_rounded,
      oneButton: false,
      onPrimaryAction: () {
        Navigator.pop(context);
        _handleDownload(context, url, fileName, videos[index].id!);
      },
      onSecondaryAction: () {
        Navigator.pop(context);
        Navigator.of(context).push(goRoute(
          x: WebViewScreen(video: videos[index]),
        ));
      },
    );
  }
}
