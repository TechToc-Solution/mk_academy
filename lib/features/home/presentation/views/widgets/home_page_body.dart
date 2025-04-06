import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/home/presentation/views/ads/advertising_section.dart';
import 'package:mk_academy/features/home/presentation/views/subjects/category_section.dart';
import 'package:mk_academy/features/home/presentation/views/ads/offers_section.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_advertising_item.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_top_3.dart';

import '../../../../../core/shared/models/subjects_model.dart';
import '../../../../leaderboard/data/models/students_leaderboard_model.dart';
import '../../../data/model/ads_model.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    super.key,
    required this.subjects,
    required this.students,
    required this.adsInt,
    required this.adsExt,
  });
  final List<SubjectsData> subjects;
  final List<StudentsLeaderboardModel> students;
  final List<Ads> adsInt;
  final List<Ads> adsExt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                for (int i = 0; i < adsExt.length; i++)
                  CustomAdvertiseItem(ads: adsExt[i]),
              ]),
              SizedBox(
                height: 8,
              ),
              CategorySection(
                subjects: subjects,
              ),
              OffersSection(
                ads: adsInt,
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        )
      ],
    );
  }
}
