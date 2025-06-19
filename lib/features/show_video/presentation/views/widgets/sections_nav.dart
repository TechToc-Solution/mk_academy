// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/styles.dart';

// ignore: must_be_immutable
class SectionsNav extends StatelessWidget {
  final TabController tabController;
  final List<String> titles;

  const SectionsNav({
    super.key,
    required this.tabController,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        tabAlignment: TabAlignment.center,
        isScrollable: true,
        indicatorColor: AppColors.primaryColors,
        labelColor: AppColors.primaryColors,
        unselectedLabelColor: AppColors.textColor,
        dividerColor: AppColors.primaryColors,
        indicatorWeight: 5,
        dividerHeight: 0.5,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          for (int i = 0; i < titles.length; i++)
            Tab(
              child: Text(
                titles[i],
                style: Styles.textStyle20
                    .copyWith(color: AppColors.backgroundColor),
              ),
            ),
        ],
      ),
    );
  }
}
