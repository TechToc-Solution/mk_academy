import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/login/login_page.dart';
import '../../features/auth/presentation/views/register/register_page.dart';
import '../../features/auth/presentation/views/verification_phone/verification_phone_page.dart';
import '../../features/home/presentation/views/home_page.dart';
import '../../features/leaderboard/presentation/views/leaderboard.dart';
import '../../features/profile/presentation/views/profile_page.dart';
import '../../features/show_unit/presentation/views/unit.dart';
import '../../features/test_your_self/presentation/views/questions_test_page.dart';
import '../../features/test_your_self/presentation/views/test_result_page.dart';
import '../../features/units/presentation/views/units.dart';
import '../widgets/custom_bottom_nav_bar.dart';

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
    CustomBottomNavBar.routeName: (context) => CustomBottomNavBar(),
    ProfilePage.routeName: (context) => const ProfilePage(),
    QuestionsTestPage.routeName: (context) => const QuestionsTestPage(),
    TestResultPage.routeName: (context) => const TestResultPage(),
    VerificationPhonePage.routeName: (context) =>
        VerificationPhonePage(phoneNumber: "")
  };
}
