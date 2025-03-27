import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/test_lists.dart';
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
                Spacer(),
                SubjectNameItem(
                    onTap: () =>
                        Navigator.pushNamed(context, TestListBody.routeName),
                    title: "partialـexams".tr(context),
                    price: "",
                    screenWidth: screenWidth),
                SizedBox(
                  height: kSizedBoxHeight,
                ),
                SubjectNameItem(
                    onTap: () =>
                        Navigator.pushNamed(context, TestListBody.routeName),
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
}
