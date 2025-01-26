import 'package:flutter/material.dart';
import 'package:mk_academy/core/widgets/custom_bottom_nav_bar.dart';
import 'package:mk_academy/features/auth/presentation/views/login/login_page.dart';
import 'package:mk_academy/features/leaderboard/presentation/views/leaderboard.dart';
import 'package:mk_academy/features/show_unit/presentation/views/unit.dart';
import 'package:mk_academy/features/units/presentation/views/units.dart';

import '../../features/auth/presentation/views/register/register_page.dart';
import '../../features/home/presentation/views/home_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    HomePage.routeName: (context) => const HomePage(),
    LoginPage.routeName: (context) => const LoginPage(),
    RegisterPage.routeName: (context) => const RegisterPage(),
    UnitsPage.routeName: (context) => const UnitsPage(),
    UnitPage.routeName: (context) => const UnitPage(title: ""),
    LeaderboardPage.routeName: (context) => const LeaderboardPage(
          back_btn: false,
        ),
    CustomBottomNavBar.routeName: (context) =>
        CustomBottomNavBar(select: "home")
  };
}
