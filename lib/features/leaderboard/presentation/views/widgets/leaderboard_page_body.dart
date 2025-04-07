import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../core/utils/constats.dart';
import '../../../data/models/students_leaderboard_model.dart';
import 'leaderboard_section.dart';

class LeaderboardPageBody extends StatelessWidget {
  final List<StudentsLeaderboardModel> students;
  const LeaderboardPageBody({
    super.key,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: ListView(
        children: [
          if (students.isNotEmpty)
            LeaderboardSection(
              students: students,
            ),
          if (students.isEmpty) Center(child: Text("no_data".tr(context))),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
