import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/styles.dart';

class ProfileTabBar extends StatelessWidget {
  final TabController tabController;
  const ProfileTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: TabBar(
        controller: tabController,
        indicatorColor: AppColors.primaryColors,
        labelColor: AppColors.primaryColors,
        unselectedLabelColor: AppColors.ProfileTextColor,
        dividerColor: AppColors.primaryColors,
        indicatorWeight: 5,
        dividerHeight: 0.5,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            child: Text(
              'Subscriptions',
              style: Styles.textStyle20
                  .copyWith(color: AppColors.ProfileTextColor),
            ),
          ),
          Tab(
            child: Text(
              'level',
              style: Styles.textStyle20
                  .copyWith(color: AppColors.ProfileTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
