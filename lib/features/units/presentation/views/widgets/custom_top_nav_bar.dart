// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/styles.dart';

class CustomTopNavBar extends StatelessWidget {
  final TabController tabController;
  List<Subjects> subjects;
  CustomTopNavBar({
    Key? key,
    required this.tabController,
    required this.subjects,
  }) : super(key: key);

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
          for (int i = 0; i < subjects.length; i++)
            Tab(
              child: Text(
                subjects[i].name!,
                style: Styles.textStyle20.copyWith(color: AppColors.textColor),
              ),
            ),
        ],
      ),
    );
  }
}
