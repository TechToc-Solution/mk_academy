import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/auth/data/models/courses_model.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import '../../../../../core/utils/styles.dart';

class SubscriptionsSection extends StatelessWidget {
  final List<Courses> courses;
  const SubscriptionsSection({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty)
      return Center(
        child: Text("there_is_no_subs".tr(context),
            style: Styles.textStyle16.copyWith(
                color: AppColors.textColor, fontWeight: FontWeight.bold)),
      );
    if (courses.isNotEmpty)
      return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildSubscriptionItem(courses[index].purchasedDate!,
              courses[index].price!.toString(), courses[index].name!, context);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 12);
        },
      );
    return SizedBox();
  }

  Widget _buildSubscriptionItem(
      String date, String cost, String subName, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    subName,
                    style: Styles.textStyle25.copyWith(
                        color: AppColors.primaryColors,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(cost,
                      style: Styles.textStyle16.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                ],
              ),
              MaterialButton(
                  height: 25,
                  color: AppColors.primaryColors,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  onPressed: () {},
                  child: Text(
                    "moore".tr(context),
                    style: Styles.textStyle15
                        .copyWith(color: AppColors.backgroundColor),
                  )),
            ],
          ),
        ),
        Text('${"subs_date".tr(context)} : $date',
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
