import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'package:mk_academy/core/widgets/custom_bottom_nav_bar.dart';

import '../../../../core/utils/assets_data.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class TestResultPage extends StatelessWidget {
  final int score;
  final int quizScore;
  static const String routeName = "testResult";
  const TestResultPage(
      {super.key, required this.score, required this.quizScore});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(title: "test_result".tr(context), backBtn: false),
            Spacer(),
            Center(
              child: Container(
                padding: const EdgeInsets.all(30),
                margin: EdgeInsets.all(screenWidth * 0.1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "quiz_done".tr(context),
                      textAlign: TextAlign.center,
                      style: Styles.textStyle20.copyWith(
                        color: AppColors.textButtonColors,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${"ur_socre".tr(context)}: $score/$quizScore',
                      style: Styles.textStyle20.copyWith(
                        color: AppColors.backgroundColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildActionButton(
                      icon: Icons.visibility,
                      text: "watch_solution".tr(context),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    _buildActionButton(
                      icon: Icons.download,
                      text: "download_solution".tr(context),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    _buildActionButton(
                      icon: Icons.home,
                      text: "back_home_page".tr(context),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, CustomBottomNavBar.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(
              AssetsData.logoNoBg,
              color: Colors.white,
              height: 50,
              width: 50,
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.backgroundColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.backgroundColor),
              const SizedBox(width: 5),
              Text(
                text,
                style: Styles.textStyle15.copyWith(
                  color: AppColors.backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
