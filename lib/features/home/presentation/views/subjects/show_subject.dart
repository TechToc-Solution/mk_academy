// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/questions_test_page.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/back_ground_image.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/subject_name_item.dart';

class ShowSubSubjects extends StatelessWidget {
  static const routeName = '/SubSubjects';
  ShowSubSubjects({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Retrieve the arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Get the testType value
    final SubjectsData subject = args?['subject'];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundImage(),
            Column(
              children: [
                CustomAppBar(
                  title: subject.name!,
                  backBtn: true,
                ),
                SizedBox(
                  height: kSizedBoxHeight,
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kSizedBoxHeight),
                  child: subject.subjects == null
                      ? Text(
                          "no_data".tr(context),
                          style: TextStyle(color: Colors.white),
                        )
                      : ListView.builder(
                          itemCount: subject.subjects!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SubjectNameItem(
                                onTap: () => Navigator.pushReplacementNamed(
                                    context, QuestionsTestPage.routeName),
                                title: subject.subjects![index].name!,
                                price: "",
                                screenWidth: screenWidth);
                          },
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
