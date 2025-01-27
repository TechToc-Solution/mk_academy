import 'package:flutter/material.dart';
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
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 8.0,
            right: 8.0,
          ),
          child: Column(
            children: [
              CustomAppBar(title: "الترتيب", back_btn: widget.back_btn),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  child: ListView(
                children: [
                  LeaderboardSection(),
                  SizedBox(
                    height: 16,
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
