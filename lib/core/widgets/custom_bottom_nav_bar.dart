import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/features/home/presentation/views/home_page.dart';
import 'package:mk_academy/features/profile/presentation/views/profile_page.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class CustomBottomNavBar extends StatefulWidget {
  final String select;
  const CustomBottomNavBar({
    super.key,
    required this.select,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with SingleTickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  @override
  void initState() {
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        labels: const ["Home", "Profile", "Settings"],
        icons: const [
          Icons.home_outlined,
          Icons.person_outline,
          Icons.settings_outlined
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
          if (index == 0 && widget.select != "Home") {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          } else if (index == 1 && widget.select != "profile") {
            Navigator.pushReplacementNamed(context, ProfilePage.routeName);
          } else if (index == 2) {}
        },
      ),
    );
  }
}
