import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';

class CustomTopNavBarBtn extends StatelessWidget {
  const CustomTopNavBarBtn({
    super.key,
    required this.title,
    required this.index,
  });
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:
              index == 0 ? AppColors.primaryColors : AppColors.backgroundColor),
      child: Text(
        title,
        style: TextStyle(
            color: index == 0
                ? AppColors.backgroundColor
                : AppColors.primaryColors,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
