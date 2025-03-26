import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:shimmer/shimmer.dart';

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
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 12 / 9,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[100]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              margin: margin,
              // alignment: Alignment.center,
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: Colors.grey[100]!,
                  borderRadius: BorderRadius.circular(kBorderRadius)),
            ),
          );
        });
  }
}
