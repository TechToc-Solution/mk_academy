import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/home/presentation/views/ads/advertising_section.dart';
import 'package:mk_academy/features/home/presentation/views/subjects/category_section.dart';
import 'package:mk_academy/features/home/presentation/views/drawer.dart';
import 'package:mk_academy/features/home/presentation/views/ads/offers_section.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_advertising_item.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_top_3.dart';

import '../../../../../core/shared/models/subjects_model.dart';
import '../../../../leaderboard/data/models/students_leaderboard_model.dart';
import '../../../data/model/ads_model.dart';

class HomePageBody extends StatelessWidget {
  HomePageBody(
      {super.key,
      required this.subjects,
      required this.students,
      required this.ads});
  final List<SubjectsData> subjects;
  final List<StudentsLeaderboardModel> students;
  final List<Ads> ads;
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding, vertical: kVerticalPadding),
          child: SliderDrawer(
            isDraggable: false,
            slideDirection: SlideDirection.rightToLeft,
            key: _sliderDrawerKey,
            backgroundColor: AppColors.backgroundColor,
            slider: CustomDrawer(),
            appBar: SizedBox(),
            child: Column(
              children: [
                CustomSearchBar(drawerKey: _sliderDrawerKey),
                SizedBox(
                  height: 8,
                ),
                if (!isGuest) CustomLevelBar(),
                Expanded(
                    child: ListView(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    CustomAdvertiseList(advertises: [
                      CustomTopThreeItem(students: students),
                      CustomAdvertiseItem(),
                      CustomAdvertiseItem(),
                      CustomAdvertiseItem(),
                      CustomAdvertiseItem(),
                    ]),
                    SizedBox(
                      height: 8,
                    ),
                    CategorySection(
                      subjects: subjects,
                    ),
                    OffersSection(
                      ads: ads,
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
