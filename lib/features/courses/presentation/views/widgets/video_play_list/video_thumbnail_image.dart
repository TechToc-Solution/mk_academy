import 'package:flutter/material.dart';

import '../../../../../../core/utils/assets_data.dart';
import '../../../../data/model/video_model.dart';

class VideoThumbnailImage extends StatelessWidget {
  const VideoThumbnailImage({
    super.key,
    required this.video,
  });

  final Video video;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: video.thumbnail == null
          ? Image.asset(
              AssetsData.logo,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            )
          : Image.network(
              video.thumbnail!,
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
    );
  }
}
