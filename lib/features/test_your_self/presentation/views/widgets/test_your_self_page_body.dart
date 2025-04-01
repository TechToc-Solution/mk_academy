import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/test_lists.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundImage(),
            Column(
              children: [
                CustomAppBar(
                  title: "test_your_self".tr(context),
                  backBtn: true,
                ),
                Spacer(),
                SubjectNameItem(
                    onTap: () => onTap(context, {'testType': 1}),
                    title: "partialـexams".tr(context),
                    price: "",
                    screenWidth: screenWidth),
                SizedBox(
                  height: kSizedBoxHeight,
                ),
                SubjectNameItem(
                    onTap: () => onTap(context, {'testType': 0}),
                    title: "general_exams".tr(context),
                    price: "",
                    screenWidth: screenWidth),
                Spacer()
              ],
            ),
          ],
        ),
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
      Navigator.pushNamed(context, TestListBody.routeName, arguments: arg);
    }
  }
}
