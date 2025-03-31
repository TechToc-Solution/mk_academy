import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/auth/presentation/view-model/logout_cubit/logout_cubit.dart';
import 'package:mk_academy/features/auth/presentation/views/login/login_page.dart';
import 'package:mk_academy/features/leaderboard/presentation/views/leaderboard.dart';
import 'package:mk_academy/features/profile/presentation/views/profile_page.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/test_your_self_page.dart';
import 'package:mk_academy/features/work%20papers/presentation/views/work_papers_page.dart';

import '../../../../core/utils/colors.dart';
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
          CustomLevelBar(
            isDrawer: true,
          ),
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
            onTap: () {
              if (isGuset) {
                showLoginDialog(context);
              } else {
                Navigator.of(context).push(goRoute(
                    x: LeaderboardPage(
                  backBtn: true,
                )));
              }
            },
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
          GestureDetector(
            onTap: () {
              if (isGuset) {
                showLoginDialog(context);
              } else {
                Navigator.of(context).push(goRoute(x: WorkPapersPage()));
              }
            },
            child: CustomDrawerBtn(
              title: "work_papers".tr(context),
              icon: Icons.library_books_outlined,
            ),
          ),
          if (!isGuset)
            BlocConsumer<LogoutCubit, LogoutState>(
              listener: (BuildContext context, LogoutState state) {
                if (state is LogoutSuccess) {
                  messages(context, "success_logout".tr(context), Colors.green);
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                }
                if (state is LogoutError) {
                  messages(context, state.errorMsg, Colors.red);
                }
              },
              builder: (context, state) {
                if (state is LogoutLoading) {
                  return CustomDrawerLoadingBtn(
                    icon: Icons.logout,
                  );
                }
                return GestureDetector(
                  onTap: () => context.read<LogoutCubit>().logout(),
                  child: CustomDrawerBtn(
                    title: "logout".tr(context),
                    icon: Icons.logout,
                  ),
                );
              },
            ),
          if (isGuset)
            GestureDetector(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, LoginPage.routeName),
              child: CustomDrawerBtn(
                icon: Icons.login_outlined,
                title: "login".tr(context),
              ),
            ),
          if (!isGuset)
            CustomDrawerBtn(
              title: "delete_account".tr(context),
              icon: Icons.delete,
            ),
        ],
      ),
    );
  }

  void showLoginDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: "req_login".tr(context),
      description: "you_should_login".tr(context),
      primaryButtonText: "login".tr(context),
      onPrimaryAction: () {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      },
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

class CustomDrawerLoadingBtn extends StatelessWidget {
  const CustomDrawerLoadingBtn({
    super.key,
    required this.icon,
  });

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
        children: [
          Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColors,
            ),
          ),
          Icon(icon)
        ],
      ),
    );
  }
}
