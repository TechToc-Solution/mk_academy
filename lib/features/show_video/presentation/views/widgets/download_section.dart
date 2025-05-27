// lib/features/courses/presentation/views/video_play_list/widgets/download_section.dart

import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:mk_academy/features/courses/presentation/views/widgets/video_play_list/download_file_bloc_consumer.dart';

class DownloadSection extends StatelessWidget {
  final Video? video;

  const DownloadSection({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (video?.video != null)
          _buildDownloadItem(context, 'download_video', video!),
        if (video?.filePath != null)
          _buildDownloadItem(context, 'download_file', video!),
      ],
    );
  }

  Widget _buildDownloadItem(
      BuildContext context, String labelKey, Video video) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          labelKey.tr(context),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        trailing: DownloadFileBlocConsumer(video: video),
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
