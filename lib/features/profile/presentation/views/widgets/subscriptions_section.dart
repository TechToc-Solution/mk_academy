import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import '../../../../../core/utils/styles.dart';

class SubscriptionsSection extends StatelessWidget {
  const SubscriptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(height: 12),
        _buildSubscriptionItem('2025/1/9', ' 500.000 sp', 'جبر'),
        _buildSubscriptionItem('2025/1/9', ' 500.000 sp', "اشعة"),
        _buildSubscriptionItem('2025/1/9', ' 500.000 sp', "جبر"),
      ],
    );
  }

  Widget _buildSubscriptionItem(String date, String cost, String subName) {
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
                    "المزيد",
                    style: Styles.textStyle15
                        .copyWith(color: AppColors.backgroundColor),
                  )),
            ],
          ),
        ),
        Text('تاريخ الاشتراك : $date',
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
