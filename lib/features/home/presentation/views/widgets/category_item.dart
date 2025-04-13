import 'package:flutter/material.dart';
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
              child: Image.network(
                subject.image ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Image load failed for ${subject.image}: $error');
                  return Image.asset(
                    AssetsData.logo,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            overflow: TextOverflow.ellipsis,
            subject.name!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
