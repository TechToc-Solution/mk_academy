import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'package:mk_academy/core/widgets/custom_bottom_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: unused_import
import '../../../../core/shared/cubits/solve_quizzes/solve_quizzes_cubit.dart';
import '../../../../core/utils/assets_data.dart';
import '../../../../core/utils/constats.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../leaderboard/presentation/views-model/leaderboard_cubit.dart';
import '../../../profile/presentation/views-model/profile_cubit.dart';

class TestResultPage extends StatelessWidget {
  final int score;
  final int quizScore;
  final String? answerPath;
  static const String routeName = "testResult";
  const TestResultPage({
    super.key,
    required this.score,
    required this.quizScore,
    this.answerPath,
  });
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
                    if (answerPath != null)
                      _buildActionButton(
                          icon: Icons.visibility,
                          text: "watch_solution".tr(context),
                          onPressed: () => _launchPdfUrl(context, answerPath!)),
                    // const SizedBox(height: 20),
                    // _buildActionButton(
                    //   icon: Icons.download,
                    //   text: "download_solution".tr(context),
                    //   onPressed: () {},
                    // ),
                    const SizedBox(height: 20),
                    _buildActionButton(
                      icon: Icons.home,
                      text: "back_home_page".tr(context),
                      onPressed: () {
                        isGuest
                            ? null
                            : context.read<ProfileCubit>().getProfile();
                        context
                            .read<LeaderboardCubit>()
                            .getLeaderboard(loadMore: false);
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

  Future<void> _launchPdfUrl(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      messages(context, 'could_not_open_pdf'.tr(context), Colors.red);
    }
  }
}
