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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: students.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: LeaderboardSection(
                        students: students,
                      ),
                    ),
                  ],
                )
              : SizedBox(
                  height: constraints.maxHeight,
                  child: Center(child: Text("no_data".tr(context))),
                ),
        );
      },
    );
  }
}
