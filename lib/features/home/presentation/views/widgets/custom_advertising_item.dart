import 'package:flutter/material.dart';
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
        child: Image.network(
          ads.image!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              AssetsData.defaultImage2,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
