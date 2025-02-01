import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/auth/presentation/views/login/login_page.dart';
import 'package:mk_academy/features/leaderboard/presentation/views/leaderboard.dart';
import 'package:mk_academy/features/profile/presentation/views/profile_page.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/test_your_self_page.dart';

import '../../../../core/utils/functions.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          CircleAvatar(
            radius: 64,
          ),
          Text(
            textAlign: TextAlign.center,
            "اسم الطالب",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          customLevelBar(),
          SizedBox(
            height: kSizedBoxHeight,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(goRoute(x: ProfilePage())),
            child: CustomDrawerBtn(
              title: "profile".tr(context),
              icon: Icons.person,
            ),
          ),
          CustomDrawerBtn(
            title: "settings".tr(context),
            icon: Icons.settings,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(goRoute(
                x: LeaderboardPage(
              back_btn: true,
            ))),
            child: CustomDrawerBtn(
              title: "leaderboard".tr(context),
              icon: Icons.leaderboard,
            ),
          ),
          CustomDrawerBtn(
            title: "who_are_we".tr(context),
            icon: Icons.people,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              goRoute(x: TestYourSelfPage()),
            ),
            child: CustomDrawerBtn(
              title: "test_your_self".tr(context),
              icon: Icons.sports_handball_rounded,
            ),
          ),
          CustomDrawerBtn(
            title: "work_papers".tr(context),
            icon: Icons.library_books_outlined,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              goRoute(x: LoginPage()),
            ),
            child: CustomDrawerBtn(
              title: "logout".tr(context),
              icon: Icons.logout,
            ),
          ),
          CustomDrawerBtn(
            title: "delete_account".tr(context),
            icon: Icons.delete,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class CustomDrawerBtn extends StatelessWidget {
  const CustomDrawerBtn({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Icon(icon)],
      ),
    );
  }
}
