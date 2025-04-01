import 'package:flutter/material.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/utils/colors.dart';

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
            child: Icon(
              Icons.category,
              size: 32,
              color: AppColors.backgroundColor,
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
