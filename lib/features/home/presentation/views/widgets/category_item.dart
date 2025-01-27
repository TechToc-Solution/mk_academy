import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
  });

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
            "عنوان تجريبي",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
