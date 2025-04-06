import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import '../../../../../core/utils/styles.dart';

class SubjectNameItem extends StatelessWidget {
  const SubjectNameItem({
    super.key,
    required this.screenWidth,
    required this.title,
    required this.questionsQount,
    required this.onTap,
  });

  final double screenWidth;
  final String title;
  final int? questionsQount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: screenWidth * 0.63,
              height: 75,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: Styles.textStyle16.copyWith(
                      color: AppColors.textColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          if (questionsQount != null)
            Text(
              "${'questions'.tr(context)}: $questionsQount",
              style: Styles.textStyle20.copyWith(
                  color: AppColors.textColor, fontWeight: FontWeight.w500),
            ),
          const SizedBox(height: kSizedBoxHeight),
        ],
      ),
    );
  }
}
