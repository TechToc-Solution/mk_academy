import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/show_unit/presentation/views/unit.dart';

class CustomCategoryUnitBtn extends StatelessWidget {
  const CustomCategoryUnitBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(goRoute(x: UnitPage(title: "نص تجريبي")));
      },
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
