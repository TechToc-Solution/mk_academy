import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mk_academy/core/widgets/shimmer_container.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';

import '../../../../../../core/utils/assets_data.dart';

class VideoThumbnailImage extends StatelessWidget {
  const VideoThumbnailImage({
    super.key,
    required this.video,
  });

  final Video video;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: video.thumbnail == null
          ? Image.asset(
              AssetsData.logo,
              fit: BoxFit.cover,
            )
          : CachedNetworkImage(
              imageUrl: video.thumbnail!,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                child: Center(
                  child: ShimmerWidget(
                    margin: EdgeInsets.all(0),
                    width: 60,
                    height: 60,
                    radius: 8,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                AssetsData.logo,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
