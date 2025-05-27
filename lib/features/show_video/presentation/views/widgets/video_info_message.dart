// lib/features/courses/presentation/views/video_play_list/widgets/video_info_message.dart

import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

class VideoInfoMessage extends StatelessWidget {
  final bool show;

  const VideoInfoMessage({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        'finish_video_to_mark'.tr(context),
        style: TextStyle(
          color: Colors.grey[700],
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
