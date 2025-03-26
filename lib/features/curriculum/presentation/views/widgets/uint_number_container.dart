import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/styles.dart';

class UintNumberContainer extends StatelessWidget {
  final String unitNumber;
  const UintNumberContainer({
    super.key,
    required this.unitNumber,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: width * 0.8,
        height: 55,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border.all(
            color: AppColors.primaryColors,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            unitNumber,
            style: Styles.textStyle25.copyWith(color: AppColors.textColor),
          ),
        ),
      ),
    );
  }
}
