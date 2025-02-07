import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/questions_test_page.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/styles.dart';

class CustomVideoItem extends StatelessWidget {
  const CustomVideoItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "الدرس الاول",
              style: Styles.textStyle20.copyWith(color: AppColors.textColor),
            ),
            Text(
              "الاشتقاق",
              style: Styles.textStyle20.copyWith(color: AppColors.textColor),
            ),
            MaterialButton(
                height: 25,
                color: AppColors.avatarColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                onPressed: () {
                  //open youtube
                  Navigator.of(context).push(
                    goRoute(x: QuestionsTestPage()),
                  );
                },
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
