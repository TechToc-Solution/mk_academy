import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/widgets/custom_buttom_sheet.dart';
import 'package:mk_academy/features/courses/data/model/courses_model.dart';
import 'package:mk_academy/features/courses/presentation/views/widgets/custom_video_details_sheet.dart';

class CustomVideoUnitBtn extends StatefulWidget {
  const CustomVideoUnitBtn({super.key, required this.course});
  final Courses course;

  @override
  State<CustomVideoUnitBtn> createState() => _CustomVideoUnitBtnState();
}

class _CustomVideoUnitBtnState extends State<CustomVideoUnitBtn> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            CustomBottomSheet.show(
                heightFactor: 0.6,
                title: widget.course.name,
                backgroundColor: AppColors.backgroundColor,
                context: context,
                child: CustomVideoDetailsSheet(courseId: widget.course.id!));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              image: DecorationImage(
                onError: (exception, stackTrace) {
                  setState(() {
                    _hasError = true;
                  });
                },
                image: _hasError || widget.course.image == null
                    ? AssetImage(AssetsData.defaultImage3)
                    : NetworkImage(widget.course.image!),
                fit: BoxFit.fill,
              ),
              border: Border.all(color: AppColors.primaryColors, width: 2),
              borderRadius: BorderRadius.circular(16),
              color: AppColors.backgroundColor,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(102),
                borderRadius: BorderRadius.circular(14),
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                final fontSize =
                    constraints.maxWidth / (widget.course.name!.length / 2);
                return Center(
                  child: Text(
                    widget.course.name!,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      shadows: const [
                        Shadow(color: Colors.black, blurRadius: 20),
                        Shadow(color: AppColors.primaryColors, blurRadius: 5)
                      ],
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize.clamp(12, 24),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryColors,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
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
