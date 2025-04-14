import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/download_handler/download_handler_cubit.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/enums.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views/show_video.dart';

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
                    BlocConsumer<DownloadCubit, DownloadStatus>(
                      builder: (context, state) {
                        return CustomCircularIcon(
                          showProgress: state == DownloadStatus.downloading,
                          icon: Icons.download_for_offline_rounded,
                          onTap: () {
                            if (videos[index].filePath != null) {
                              _handleDownload(context, videos[index].filePath!,
                                  videos[index].name!);
                            } else {
                              messages(
                                  context,
                                  "video_not_available_message".tr(context),
                                  Colors.grey);
                            }
                          },
                        );
                      },
                      listener: (BuildContext context, DownloadStatus state) {
                        if (state == DownloadStatus.completed) {
                          messages(context, "تم تحميل الملف", Colors.green);
                        }
                        if (state == DownloadStatus.failed) {}
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        videos[index].name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (videos[index].duration != null)
                        Text(
                          "المدة: ${videos[index].duration}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    videos[index].thumbnail!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      AssetsData.logo,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleDownload(BuildContext context, String url, String fileName) {
    final cubit = context.read<DownloadCubit>();

    cubit.startDownload(
      url: url,
      fileName: fileName,
    );
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
        _handleDownload(context, url, fileName);
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

class CustomCircularIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool showProgress;

  const CustomCircularIcon({
    super.key,
    required this.icon,
    this.onTap,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColors,
            ),
            child: Icon(
              icon,
              size: 24,
              color: Colors.white,
            ),
          ),
          if (showProgress)
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            ),
        ],
      ),
    );
  }
}
