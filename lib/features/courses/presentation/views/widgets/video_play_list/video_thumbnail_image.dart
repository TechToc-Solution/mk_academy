import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mk_academy/core/widgets/shimmer_container.dart';

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
          : CachedNetworkImage(
              imageUrl: video.thumbnail!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                width: 60,
                height: 60,
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
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
