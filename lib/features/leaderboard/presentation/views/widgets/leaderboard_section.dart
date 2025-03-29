import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/features/leaderboard/presentation/views/widgets/custom_leaderboard_show.dart';

import '../../../data/models/students_leaderboard_model.dart';

class LeaderboardSection extends StatelessWidget {
  final List<StudentsLeaderboardModel> students;
  const LeaderboardSection({
    super.key,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: students.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CustomLeaderboardShow(
              index: index,
              students: students,
              isYou: CacheHelper.getData(key: "userId") ==
                  students[index].id.toString());
        });
  }
}
