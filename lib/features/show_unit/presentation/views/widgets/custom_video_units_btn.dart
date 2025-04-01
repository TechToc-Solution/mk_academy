import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/courses/data/model/courses_model.dart';
import 'package:mk_academy/features/show%20video/presentation/views/show_video.dart';

class CustomVideoUnitBtn extends StatelessWidget {
  const CustomVideoUnitBtn({super.key, required this.course});
  final Courses course;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColors, width: 2),
            borderRadius: BorderRadius.circular(16),
            color: AppColors.backgroundColor,
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                course.name!,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Text(
                "${course.price!.toString()} ${"sp".tr(context)}",
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 18),
              ),
              Text(
                course.courseMode!,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 18),
              ),
            ],
          )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(4),
              color: AppColors.backgroundColor,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.primaryColors,
                    borderRadius: BorderRadius.circular(8)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(goRoute(x: WebViewScreen()));
                  },
                  child: Icon(
                    course.can_show ?? false
                        ? Icons.play_arrow_outlined
                        : Icons.lock_outline_sharp,
                    size: 30,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.info,
                color: AppColors.primaryColors,
                size: 32,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
