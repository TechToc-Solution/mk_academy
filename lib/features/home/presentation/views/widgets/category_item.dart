import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/utils/assets_data.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  CategoryItem({super.key, required this.subject});
  SubjectsData subject;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: subject.image ?? '',
                fit: BoxFit.cover,
                width: 64,
                height: 64,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 64,
                    height: 64,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, error, stackTrace) {
                  // debugPrint('Image load failed for ${subject.image}: $error');
                  return Image.asset(
                    AssetsData.logo,
                    fit: BoxFit.cover,
                    width: 64,
                    height: 64,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            overflow: TextOverflow.ellipsis,
            subject.name!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
