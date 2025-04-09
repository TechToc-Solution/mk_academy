import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/colors.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer(
      {super.key, this.width, this.height, this.circularRadius, this.margin});
  final double? width;
  final double? height;
  final double? circularRadius;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: AppColors.baseShimmerColor,
            highlightColor: AppColors.highLightShimmerColor,
            child: Container(
              margin: margin,
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: AppColors.baseShimmerColor,
                  borderRadius: BorderRadius.circular(kBorderRadius)),
            ),
          );
        });
  }
}
