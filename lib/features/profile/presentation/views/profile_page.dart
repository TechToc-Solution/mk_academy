import 'package:flutter/material.dart';
import 'package:mk_academy/core/widgets/custom_bottom_nav_bar.dart';

import 'widgets/profile_page_body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static const String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(select: "Profile"),
      body: ProfilePageBody(),
    );
  }
}
