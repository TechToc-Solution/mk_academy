import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';

class CustomCategoryUnitBtn extends StatelessWidget {
  final void Function() onTap;
  const CustomCategoryUnitBtn({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColors, width: 2),
          borderRadius: BorderRadius.circular(16),
          color: AppColors.backgroundColor,
        ),
        child: Center(
            child: Text(
          "نص تجريبي",
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        )),
      ),
    );
  }
}
