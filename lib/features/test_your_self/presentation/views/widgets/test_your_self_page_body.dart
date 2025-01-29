import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'back_ground_image.dart';
import 'subject_name_item.dart';

class TestYourSelfPageBody extends StatelessWidget {
  const TestYourSelfPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 1.5),
        child: SafeArea(
            child: CustomAppBar(
                title: "test_your_self".tr(context), back_btn: true)),
      ),
      body: Stack(
        children: [
          BackgroundImage(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenWidth * 0.1),
            child: Column(
              children: [
                const SizedBox(height: kSizedBoxHeight),
                SubjectNameItem(screenWidth: screenWidth),
                SubjectNameItem(screenWidth: screenWidth),
                SubjectNameItem(screenWidth: screenWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
