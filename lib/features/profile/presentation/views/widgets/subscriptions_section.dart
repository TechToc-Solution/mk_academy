import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/auth/data/models/courses_model.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_buttom_sheet.dart';
import '../../../../courses/presentation/views/widgets/custom_video_details_sheet.dart';

class SubscriptionsSection extends StatelessWidget {
  final List<UserCourses> courses;
  const SubscriptionsSection({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Center(
        child: Text("there_is_no_subs".tr(context),
            style: Styles.textStyle16.copyWith(
                color: AppColors.textColor, fontWeight: FontWeight.bold)),
      );
    }
    if (courses.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildSubscriptionItem(courses[index], context);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 12);
        },
      );
    }
    return SizedBox();
  }

  Widget _buildSubscriptionItem(UserCourses course, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          course.name!,
          style: Styles.textStyle20.copyWith(
              color: AppColors.primaryColors, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("${"price".tr(context)}: ${course.price}",
                      style: Styles.textStyle16.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                ],
              ),
              MaterialButton(
                  height: 25,
                  color: AppColors.primaryColors,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  onPressed: () {
                    CustomBottomSheet.show(
                        heightFactor: 0.6,
                        title: course.name,
                        backgroundColor: AppColors.backgroundColor,
                        context: context,
                        child: CustomVideoDetailsSheet(courseId: course.id!));
                  },
                  child: Text(
                    "moore".tr(context),
                    style: Styles.textStyle15
                        .copyWith(color: AppColors.backgroundColor),
                  )),
            ],
          ),
        ),
        Text('${"subs_date".tr(context)} : ${course.purchasedDate}',
            style: Styles.textStyle16.copyWith(color: Colors.white)),
        Divider(
          color: AppColors.primaryColors,
          height: kSizedBoxHeight,
          thickness: 0.5,
        )
      ],
    );
  }
}
