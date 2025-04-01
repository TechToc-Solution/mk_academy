import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/curriculum/data/model/lesson_model.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/styles.dart';

class CustomLessonsItem extends StatelessWidget {
  const CustomLessonsItem({
    super.key,
    required this.lesson,
    required this.onPressed,
    required this.lessonNum,
    required this.actionButton,
  });

  final Lesson lesson;
  final int lessonNum;
  final VoidCallback onPressed;
  final Widget actionButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${"lesson".tr(context)} $lessonNum",
              style:
                  Styles.textStyle15.copyWith(color: AppColors.primaryColors),
            ),
            Flexible(
              child: Text(
                lesson.name,
                textAlign: TextAlign.center,
                style: Styles.textStyle18.copyWith(color: AppColors.textColor),
              ),
            ),
            MaterialButton(
              height: 25,
              color: AppColors.avatarColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              onPressed: onPressed,
              child: Text(
                "watch".tr(context),
                style: Styles.textStyle13.copyWith(
                  color: AppColors.backgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        actionButton,
        const Divider(
          color: AppColors.primaryColors,
          thickness: 0.5,
          height: 20,
        ),
      ],
    );
  }
}
