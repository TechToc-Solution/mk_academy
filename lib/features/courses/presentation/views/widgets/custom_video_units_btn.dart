import 'package:cached_network_image/cached_network_image.dart';
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
                child: CustomVideoDetailsSheet(
                  courseId: widget.course.id!,
                  canShow: true,
                ));
          },
          child: Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColors, width: 2),
                borderRadius: BorderRadius.circular(16),
                color: AppColors.backgroundColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (_hasError || widget.course.image == null)
                      Image.asset(
                        AssetsData.defaultImage3,
                        fit: BoxFit.fill,
                      )
                    else
                      CachedNetworkImage(
                        imageUrl: widget.course.image!,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) {
                          setState(() {
                            _hasError = true;
                          });
                          return Image.asset(
                            AssetsData.defaultImage3,
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(102),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: LayoutBuilder(builder: (context, constraints) {
                        final fontSize = constraints.maxWidth /
                            (widget.course.name!.length / 2);
                        return Center(
                          child: Text(
                            widget.course.name!,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              shadows: const [
                                Shadow(color: Colors.black, blurRadius: 20),
                                Shadow(
                                    color: AppColors.primaryColors,
                                    blurRadius: 5)
                              ],
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize.clamp(12, 24),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              )),
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
