import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import '../../../../../core/utils/styles.dart';

class SubjectNameItem extends StatelessWidget {
  const SubjectNameItem({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.65,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                "جبر",
                style: Styles.textStyle30.copyWith(
                    color: AppColors.textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            "السعر :50000sp",
            style: Styles.textStyle20.copyWith(
                color: AppColors.textColor, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: kSizedBoxHeight),
        ],
      ),
    );
  }
}
