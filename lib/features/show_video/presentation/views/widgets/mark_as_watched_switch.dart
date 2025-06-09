// lib/features/courses/presentation/views/video_play_list/widgets/mark_as_watched_switch.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/mark_as_watched/mark_as_watched_cubit.dart';

class MarkAsWatchedSwitch extends StatelessWidget {
  bool isVideoWatched;
  final ValueChanged<bool> onToggle;

  final int videoId;
  final int courseId;
  MarkAsWatchedSwitch({
    super.key,
    required this.isVideoWatched,
    required this.onToggle,
    required this.videoId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<MarkAsWatchedCubit, MarkAsWatchedState>(
      listener: (context, state) {
        if (state.status == MarkAsWatchedStatus.success) {
          messages(context, "change_video_watch_state".tr(context),
              AppColors.primaryColors);
          onToggle(!isVideoWatched);
        } else if (state.status == MarkAsWatchedStatus.failure) {
          messages(
              context, state.errorMessage ?? "error".tr(context), Colors.red);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'mark_as_watched'.tr(context),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            BlocBuilder<MarkAsWatchedCubit, MarkAsWatchedState>(
              builder: (context, state) {
                if (state.status == MarkAsWatchedStatus.loading) {
                  return SizedBox(
                    width: 50,
                    child: LinearProgressIndicator(
                      color: AppColors.primaryColors,
                    ),
                  );
                } else {
                  return Switch(
                    value: isVideoWatched,
                    onChanged: (value) {
                      context.read<MarkAsWatchedCubit>().markAsWatched(
                            videoId: videoId,
                            courseId: courseId,
                          );
                    },
                    activeColor: AppColors.primaryColors,
                    inactiveTrackColor: Colors.grey[300],
                    inactiveThumbColor: Colors.grey[500],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
