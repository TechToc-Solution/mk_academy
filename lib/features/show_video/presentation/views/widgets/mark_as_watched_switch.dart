// lib/features/courses/presentation/views/video_play_list/widgets/mark_as_watched_switch.dart

import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';

class MarkAsWatchedSwitch extends StatelessWidget {
  final bool isVideoWatched;
  final bool isVideoCompleted;
  final ValueChanged<bool> onToggle;

  const MarkAsWatchedSwitch({
    super.key,
    required this.isVideoWatched,
    required this.isVideoCompleted,
    required this.onToggle,
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
          onChanged: (value) => onToggle(value),
          activeColor: AppColors.primaryColors,
          inactiveTrackColor: Colors.grey[300],
          inactiveThumbColor: Colors.grey[500],
        ),
      ),
    );
  }
}
