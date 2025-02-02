import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/styles.dart';

class CustomTopNavBar extends StatelessWidget {
  final TabController tabController;
  const CustomTopNavBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: TabBar(
        controller: tabController,
        indicatorColor: AppColors.primaryColors,
        labelColor: AppColors.primaryColors,
        unselectedLabelColor: AppColors.textColor,
        dividerColor: AppColors.primaryColors,
        indicatorWeight: 5,
        dividerHeight: 0.5,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            child: Text(
              "algebra".tr(context),
              style: Styles.textStyle20.copyWith(color: AppColors.textColor),
            ),
          ),
          Tab(
            child: Text(
              'analysis'.tr(context),
              style: Styles.textStyle20.copyWith(color: AppColors.textColor),
            ),
          ),
          Tab(
            child: Text(
              "geometric".tr(context),
              style: Styles.textStyle20.copyWith(color: AppColors.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
