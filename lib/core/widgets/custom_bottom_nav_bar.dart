import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/features/curriculum/presentation/views/curriculum_page.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

import '../../features/home/presentation/views/home_page.dart';
import '../../features/units/presentation/views/units.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
  });
  static const String routeName = "/nav";
  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  MotionTabBarController? _motionTabBarController;
  late PageController _pageController;

  @override
  void initState() {
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 5,
      vsync: this,
    );
    _pageController = PageController(initialPage: 2);
    super.initState();
  }

  @override
  void dispose() {
    _motionTabBarController!.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _motionTabBarController!.index = index;
        },
        children: const [
          CurriculumPage(),
          UnitsPage(),
          HomePage(),
          UnitsPage(),
          UnitsPage()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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
          controller: _motionTabBarController,
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
          textStyle: const TextStyle(
            fontSize: 15,
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
          onTabItemSelected: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }
}
