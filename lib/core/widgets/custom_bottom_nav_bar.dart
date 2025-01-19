import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';

class CustomBottomNavBar extends StatefulWidget {
  final String select;
  const CustomBottomNavBar({
    super.key,
    required this.select,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
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
        initialSelectedTab: widget.select,
        labels: const ["Home", "Profile", "Settings"],
        icons: const [
          Icons.home_outlined,
          Icons.person_outline,
          Icons.settings_outlined
        ],
        tabIconColor: Colors.blueGrey,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: const Color.fromARGB(255, 56, 70, 131),
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 15,
          color: Color(0xFF252c4a),
          fontWeight: FontWeight.w500,
        ),
        onTabItemSelected: (index) {
          if (index == 0) {
          } else if (index == 1) {
          } else if (index == 2) {}
        },
      ),
    );
  }
}
