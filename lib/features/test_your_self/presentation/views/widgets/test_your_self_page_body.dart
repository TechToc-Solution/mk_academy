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
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundImage(),
            Column(
              children: [
                CustomAppBar(
                  title: "test_your_self".tr(context),
                  back_btn: true,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: KHorizontalPadding,
                        vertical: KVerticalPadding),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: kSizedBoxHeight,
                        ),
                        ...List.generate(
                            3,
                            (index) =>
                                SubjectNameItem(screenWidth: screenWidth)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
