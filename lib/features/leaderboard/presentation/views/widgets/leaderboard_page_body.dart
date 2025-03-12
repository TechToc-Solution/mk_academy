import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: ListView(
        children: [
          LeaderboardSection(
            students: students,
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
