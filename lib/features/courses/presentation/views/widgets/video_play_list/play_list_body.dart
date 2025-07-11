import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/features/show_video/data/repo/video_repo.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/mark_as_watched/mark_as_watched_cubit.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/video_cubit/videos_cubit.dart';
import 'package:mk_academy/features/show_video/presentation/views/video_player.dart';
import 'package:mk_academy/features/show_video/presentation/views/video_player_old.dart';
import '../../../../data/model/video_model.dart';
import 'video_thumbnail_image.dart';

class PlayListBody extends StatelessWidget {
  const PlayListBody({super.key, required this.videos, required this.courseId});
  final List<Video> videos;
  final courseId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: GridView.builder(
        itemCount: videos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _buildVideoGridItem(context, videos[index]);
        },
      ),
    );
  }

  Widget _buildVideoGridItem(BuildContext context, Video video) {
    return Tooltip(
      message: video.name ?? "",
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(goRoute(
            x: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => VideoCubit(getit.get<VideoRepo>()),
                ),
                BlocProvider(
                  create: (context) =>
                      MarkAsWatchedCubit(getit.get<VideoRepo>()),
                ),
              ],
              child: Platform.isIOS ||
                      (Platform.isAndroid && sdkInt < oldDevicesVer)
                  ? VideoPlayerOldDevicesScreen(
                      videoId: video.id,
                      videoName: video.name ?? "",
                      courseId: courseId,
                    )
                  : VideoPlayerScreen(
                      videoId: video.id,
                      videoName: video.name ?? "",
                      courseId: courseId,
                    ),
            ),
          ));
        },
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.white.withOpacity(0.3),
        highlightColor: Colors.transparent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Thumbnail Background
            VideoThumbnailImage(
              video: video,
            ),

            // Overlay for better text/icon visibility
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(102),
                borderRadius: BorderRadius.circular(16),
              ),
            ),

            // Centered Play Icon (No Animation)
            const Center(
              child: Icon(
                Icons.play_circle_fill_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),

            // Video Title at Bottom Center
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(builder: (context, constraints) {
                  final fontSize =
                      constraints.maxWidth / (video.name!.length / 2);
                  return Text(
                    video.name ?? "Video",
                    style: TextStyle(
                      shadows: const [
                        Shadow(color: Colors.black, blurRadius: 20),
                        Shadow(color: AppColors.primaryColors, blurRadius: 5)
                      ],
                      color: Colors.white,
                      fontSize: fontSize.clamp(12, 24),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
