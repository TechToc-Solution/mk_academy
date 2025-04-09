import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/features/curriculum/presentation/views/curriculum_page.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import '../../features/auth/presentation/views/login/login_page.dart';
import '../../features/home/presentation/views/home_page.dart';
import '../../features/courses/presentation/views/courses_page.dart';
import '../utils/functions.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});
  static const String routeName = "/nav";

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    const CurriculumPage(),
    const CoursesPage(courseTypeId: 2), // weekly_sessions
    HomePage(),
    const CoursesPage(courseTypeId: 3), // capacitors
    const CoursesPage(courseTypeId: 1), // exam_sessions
  ];

  bool isIndexAllowed(int index) {
    if (isGuest) {
      return index == 0 || index == 2;
    }
    return true;
  }

  void _onTabSelected(int index) {
    if (!isIndexAllowed(index)) {
      handleGuestLogin(context);
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(  0.1),
              blurRadius: 8.0,
              spreadRadius: 2.0,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: MotionTabBar(
          initialSelectedTab: "home".tr(context),
          labels: [
            "curriculum".tr(context),
            "weekly_sessions".tr(context),
            "home".tr(context),
            "capacitors".tr(context),
            "exam_sessions".tr(context),
          ],
          icons: const [
            Icons.library_books_outlined,
            Icons.calendar_today_outlined,
            Icons.home_outlined,
            Icons.video_library_outlined,
            Icons.note_alt_outlined,
          ],
          useSafeArea: true,
          tabIconColor: AppColors.backgroundColor,
          tabIconSize: 30.0,
          tabIconSelectedSize: 30.0,
          tabSelectedColor: AppColors.primaryColors,
          tabIconSelectedColor: AppColors.textButtonColors,
          tabBarColor: AppColors.primaryColors,
          tabSize: 50,
          tabBarHeight: 60,
          textStyle: TextStyle(
              fontSize: 11,
              color: AppColors.backgroundColor,
              fontWeight: FontWeight.w600),
          onTabItemSelected: _onTabSelected,
        ),
      ),
    );
  }

  void handleGuestLogin(BuildContext context) {
    messages(context, "you_should_login".tr(context), Colors.red);
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }
}
