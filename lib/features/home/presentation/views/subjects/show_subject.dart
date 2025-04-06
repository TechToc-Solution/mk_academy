// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/courses/presentation/view_model/courses%20cubit/courses_cubit.dart';
import 'package:mk_academy/features/courses/presentation/views/widgets/custom_category_unit_btn.dart';
import 'package:mk_academy/features/show_unit/presentation/views/unit.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/back_ground_image.dart';

class ShowSubSubjects extends StatelessWidget {
  static const routeName = '/SubSubjects';
  const ShowSubSubjects({super.key});

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
                        padding:
                            EdgeInsets.symmetric(horizontal: kSizedBoxHeight),
                        child: subject.subjects == null
                            ? Center(
                                child: Text(
                                  "no_data".tr(context),
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : GridView.builder(
                                itemCount: subject.subjects!.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 12 / 9,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16),
                                itemBuilder: (BuildContext context, int index) {
                                  return CustomCategoryUnitBtn(
                                      unitText: subject.subjects![index].name!,
                                      onTap: () {
                                        context
                                            .read<CoursesCubit>()
                                            .resetPagination();
                                        context.read<CoursesCubit>().getCourses(
                                              courseTypeId: null,
                                              subjectId:
                                                  subject.subjects![index].id!,
                                            );
                                        Navigator.of(context).push(goRoute(
                                            x: UnitPage(
                                                subjectId: subject
                                                    .subjects![index].id!,
                                                title: subject
                                                    .subjects![index].name!)));
                                      });
                                })))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
