import 'package:flutter/material.dart';
import 'widgets/profile_page_body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static const String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfilePageBody(),
    );
  }
}
