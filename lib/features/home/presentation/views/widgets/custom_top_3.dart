import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_user_show.dart';
import 'package:mk_academy/features/leaderboard/data/models/students_leaderboard_model.dart';
import 'package:mk_academy/features/leaderboard/presentation/views/leaderboard.dart';

class CustomTopThreeItem extends StatelessWidget {
  const CustomTopThreeItem({super.key, required this.students});
  final List<StudentsLeaderboardModel> students;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.backgroundColor, Colors.white],
          end: Alignment.topCenter,
          begin: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  "top3_title".tr(context),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(goRoute(x: LeaderboardPage(backBtn: true)));
                  },
                  child: Text(
                    "show_all".tr(context),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  for (int i = 0; i < 3; i++)
                    if (i < students.length)
                      CustomUserShow(
                          top: i + 1,
                          title: students[i].name!,
                          color: Colors.amber.shade700,
                          level: students[i].level!),
      
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
