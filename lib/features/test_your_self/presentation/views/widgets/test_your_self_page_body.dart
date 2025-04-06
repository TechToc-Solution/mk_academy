import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/tests_list_page.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../auth/presentation/views/login/login_page.dart';
import 'back_ground_image.dart';
import 'subject_name_item.dart';

class TestYourSelfPageBody extends StatelessWidget {
  const TestYourSelfPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.sizeOf(context),
        child: SafeArea(
          child: CustomAppBar(
            title: "test_your_self".tr(context),
            backBtn: true,
          ),
        ),
      ),
      body: Stack(
        children: [
          const BackgroundImage(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubjectNameItem(
                  onTap: () => onTap(context, {'testType': 1}),
                  title: "partialـexams".tr(context),
                  questionsQount: null,
                  screenWidth: screenWidth),
              SizedBox(
                height: kSizedBoxHeight,
              ),
              SubjectNameItem(
                  onTap: () => onTap(context, {'testType': 0}),
                  title: "general_exams".tr(context),
                  questionsQount: null,
                  screenWidth: screenWidth),
            ],
          ),
        ],
      ),
    );
  }

  void onTap(BuildContext context, Map<String, dynamic> arg) {
    if (isGuest) {
      showCustomDialog(
        context: context,
        title: "req_login".tr(context),
        description: "you_should_login".tr(context),
        primaryButtonText: "login".tr(context),
        onPrimaryAction: () {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        },
      );
    } else {
      Navigator.pushNamed(context, TestsListPage.routeName, arguments: arg);
    }
  }
}
