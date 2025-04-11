import 'package:flutter/material.dart';
import 'package:mk_academy/features/auth/presentation/views/reset_password/reset_password_page.dart';
import 'package:mk_academy/features/home/presentation/views/ads/all_ads.dart';
import 'package:mk_academy/features/home/presentation/views/subjects/all_subjects.dart';
import 'package:mk_academy/features/home/presentation/views/subjects/show_subject.dart';
import 'package:mk_academy/features/show_video/presentation/views/show_video.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/tests_list_page.dart';
import 'package:mk_academy/splash_screen.dart';

import '../../features/auth/presentation/views/login/login_page.dart';
import '../../features/auth/presentation/views/register/register_page.dart';
import '../../features/auth/presentation/views/verification_phone/verification_phone_page.dart';
import '../../features/home/presentation/views/home_page.dart';
import '../../features/leaderboard/presentation/views/leaderboard.dart';
import '../../features/profile/presentation/views/profile_page.dart';
import '../../features/show_unit/presentation/views/unit.dart';
import '../../features/test_your_self/presentation/views/questions_test_page.dart';
import '../../features/test_your_self/presentation/views/test_result_page.dart';
import '../../features/courses/presentation/views/courses_page.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    HomePage.routeName: (context) => HomePage(),
    LoginPage.routeName: (context) => const LoginPage(),
    RegisterPage.routeName: (context) => const RegisterPage(),
    CoursesPage.routeName: (context) => CoursesPage(courseTypeId: 1),
    UnitPage.routeName: (context) => const UnitPage(
          title: "",
          subjectId: null,
        ),
    LeaderboardPage.routeName: (context) => const LeaderboardPage(
          backBtn: false,
        ),
    CustomBottomNavBar.routeName: (context) => CustomBottomNavBar(),
    ProfilePage.routeName: (context) => const ProfilePage(),
    QuestionsTestPage.routeName: (context) => const QuestionsTestPage(
          questions: [],
          quizId: 0,
          isCurriculumQuizz: false,
        ),
    TestResultPage.routeName: (context) => const TestResultPage(
          score: 0,
          quizScore: 0,
          isFromCurr: false,
        ),
    VerificationPhonePage.routeName: (context) =>
        VerificationPhonePage(fromRigster: false, phoneNumber: ""),
    ResetPasswordPage.routeName: (context) => ResetPasswordPage(),
    WebViewScreen.routeName: (context) => WebViewScreen(
          video: null,
        ),
    TestsListPage.routeName: (context) => TestsListPage(),
    ShowSubSubjects.routeName: (context) => ShowSubSubjects(),
    AllSubjects.routeName: (context) => AllSubjects(),
    AllAds.routeName: (context) => AllAds(),
    SplashScreen.routeName: (context) => SplashScreen()
  };
}
