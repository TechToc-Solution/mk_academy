import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(course.image!), fit: BoxFit.cover),
              border: Border.all(color: AppColors.primaryColors, width: 2),
              borderRadius: BorderRadius.circular(16),
              color: AppColors.backgroundColor,
            ),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black
                    .withOpacity(0.4), // Adjust opacity (0.3 to 0.7)
                borderRadius: BorderRadius.circular(16),
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                final fontSize =
                    constraints.maxWidth / (course.name!.length / 2);
                return Center(
                    child: Text(
                  course.name!,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      shadows: [
                        Shadow(color: Colors.black, blurRadius: 20),
                        Shadow(color: AppColors.primaryColors, blurRadius: 5)
                      ],
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize.clamp(12, 24)),
                ));
              }),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(8)),
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
