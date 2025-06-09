import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/courses/presentation/views/widgets/video_play_list/download_file_bloc_consumer.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';

class FileDownloadTile extends StatelessWidget {
  final VideoDataModel video;

  const FileDownloadTile({super.key, required this.video});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: boxDecoration(),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text("download_file".tr(context),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
          trailing: DownloadFileBlocConsumer(video: video),
        ),
      );
}
