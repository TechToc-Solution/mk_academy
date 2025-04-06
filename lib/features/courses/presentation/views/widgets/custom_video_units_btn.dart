import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/widgets/custom_buttom_sheet.dart';
import 'package:mk_academy/features/courses/data/model/courses_model.dart';
import 'package:mk_academy/features/courses/presentation/views/widgets/custom_video_details_sheet.dart';

class CustomVideoUnitBtn extends StatelessWidget {
  const CustomVideoUnitBtn({super.key, required this.course});
  final Courses course;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            CustomBottomSheet.show(
                title: course.name,
                backgroundColor: AppColors.backgroundColor,
                context: context,
                child: CustomVideoDetailsSheet(courseId: course.id!));
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
              course.name!,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            )),
          ),
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
                child: Icon(
                  Icons.featured_play_list,
                  size: 30,
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
