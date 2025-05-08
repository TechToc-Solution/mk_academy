import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/features/home/data/model/ads_model.dart';

class CustomAdvertiseItem extends StatelessWidget {
  const CustomAdvertiseItem({super.key, required this.ads});
  final Ads ads;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: ads.image!,
          fit: BoxFit.cover,
          errorWidget: (context, error, stackTrace) => Image.asset(
            AssetsData.defaultImage2,
            fit: BoxFit.cover,
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
