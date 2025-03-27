import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/questions_test_page.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/back_ground_image.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/subject_name_item.dart';

class TestListBody extends StatelessWidget {
  static const routeName = '/testList';
  const TestListBody({super.key});

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
                  padding: EdgeInsets.symmetric(horizontal: kSizedBoxHeight),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: kSizedBoxHeight,
                      ),
                      for (int i = 0; i < 10; i++)
                        SubjectNameItem(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, QuestionsTestPage.routeName),
                            title: "Exam $i",
                            price: "10000",
                            screenWidth: screenWidth),
                    ],
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
