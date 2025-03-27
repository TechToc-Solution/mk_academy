import 'package:flutter/material.dart';
import 'package:mk_academy/features/curriculum/data/model/lesson_model.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/styles.dart';

class CustomLessonsItem extends StatelessWidget {
  const CustomLessonsItem({
    super.key,
    required this.lesson,
    required this.onPressed,
    required this.LessonNum,
  });
  final Lesson lesson;
  final int LessonNum;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "الدرس $LessonNum",
              style: Styles.textStyle20.copyWith(color: AppColors.textColor),
            ),
            Text(
              lesson.name,
              style: Styles.textStyle20.copyWith(color: AppColors.textColor),
            ),
            MaterialButton(
                height: 25,
                color: AppColors.avatarColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                onPressed: onPressed,
                child: Text(
                  "مشاهدة",
                  style: Styles.textStyle16.copyWith(
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
        Divider(
          color: AppColors.primaryColors,
          thickness: 0.5,
          height: 20,
        ),
      ],
    );
  }
}
