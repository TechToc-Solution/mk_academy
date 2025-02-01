import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/leaderboard/presentation/views/leaderboard_section.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key, required this.back_btn});
  static const String routeName = '/leaderboard';
  final bool back_btn;
  @override
  State<LeaderboardPage> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "الترتيب", back_btn: widget.back_btn),
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
              child: ListView(
                children: [
                  LeaderboardSection(),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
