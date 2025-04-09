import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/assets_data.dart';

import '../../../data/models/students_leaderboard_model.dart';

class CustomLeaderboardShow extends StatelessWidget {
  const CustomLeaderboardShow(
      {super.key,
      required this.index,
      required this.isYou,
      required this.students});
  final int index;
  final List<StudentsLeaderboardModel> students;
  final bool isYou;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isYou,
      selectedTileColor: const Color.fromARGB(55, 0, 0, 0),
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        students[index].name!,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "${"level".tr(context)} ${students[index].level!}",
        style: TextStyle(color: Colors.white),
      ),
      trailing: index == 0
          ? Image.asset(
              AssetsData.medal1,
            )
          : index == 1
              ? Image.asset(
                  AssetsData.medal2,
                )
              : index == 2
                  ? Image.asset(
                      AssetsData.medal3,
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        textAlign: TextAlign.center,
                        (index + 1).toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32),
                      ),
                    ),
    );
  }
}
