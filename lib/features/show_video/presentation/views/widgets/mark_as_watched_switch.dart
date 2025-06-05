// lib/features/courses/presentation/views/video_play_list/widgets/mark_as_watched_switch.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/video_cubit/videos_cubit.dart';

class MarkAsWatchedSwitch extends StatelessWidget {
  final bool isVideoWatched;
  final bool isVideoCompleted;
  final ValueChanged<bool> onToggle;

  final int videoId;
  final int courseId;
  const MarkAsWatchedSwitch({
    super.key,
    required this.isVideoWatched,
    required this.isVideoCompleted,
    required this.onToggle,
    required this.videoId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: ListTile(
        title: Text(
          'mark_as_watched'.tr(context),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: Switch(
          value: isVideoWatched,
          onChanged: (value) {
            onToggle(value);

            if (value == true) {
              context.read<VideoCubit>().markAsWatched(
                    videoId: videoId,
                    courseId: courseId,
                  );
            }
          },
          activeColor: AppColors.primaryColors,
          inactiveTrackColor: Colors.grey[300],
          inactiveThumbColor: Colors.grey[500],
        ),
      ),
    );
  }
}
