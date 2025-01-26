import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/features/home/presentation/views/home_page.dart';
import 'package:mk_academy/features/leadboard/presentation/views/leadboard.dart';
import 'package:mk_academy/features/units/presentation/views/units.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class CustomBottomNavBar extends StatefulWidget {
  final String select;
  const CustomBottomNavBar({
    super.key,
    required this.select,
  });
  static const String routeName = "/nav";
  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with SingleTickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  late PageController _pageController;

  @override
  void initState() {
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 5, // Increased to 5 for 5 pages
      vsync: this,
    );
    _pageController = PageController(initialPage: 1); // Sync with initialIndex
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
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _motionTabBarController!.index = index;
        },
        children: const [
          HomePage(title: "MK Academy"),
          HomePage(title: "MK Academy"),
          HomePage(title: "MK Academy"),
          UnitsPage(),
          LeadboardPage(),
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
          initialSelectedTab: widget.select,
          labels: const [
            "Settings",
            "Profile",
            "Home",
            "Units",
            "Leadboard",
          ],
          icons: const [
            Icons.settings_outlined,
            Icons.person_outline,
            Icons.home_outlined,
            Icons.book,
            Icons.leaderboard,
          ],
          tabIconColor: AppColors.backgroundColor,
          tabIconSize: 28.0,
          tabIconSelectedSize: 26.0,
          tabSelectedColor: AppColors.primaryColors,
          tabIconSelectedColor: AppColors.textButtonColors,
          tabBarColor: AppColors.primaryColors,
          tabSize: 50,
          tabBarHeight: 55,
          textStyle: const TextStyle(
            fontSize: 15,
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
          onTabItemSelected: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}
