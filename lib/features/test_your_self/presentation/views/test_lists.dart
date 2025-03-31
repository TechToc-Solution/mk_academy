// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/test_your_self/data/repo/tests_repo.dart';
import 'package:mk_academy/features/test_your_self/presentation/view_model/test_your_self_cubit.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/questions_test_page.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/back_ground_image.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/subject_name_item.dart';

class TestListBody extends StatelessWidget {
  static const routeName = '/testList';
  TestListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Retrieve the arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Get the testType value
    final int testType = args?['testType'] ?? 0; // Default to 0 if null
    return BlocProvider(
      create: (context) => TestYourSelfCubit(getit.get<TestsRepo>())
        ..getTests(testsType: testType),
      child: Scaffold(
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
                  BlocBuilder<TestYourSelfCubit, TestYourSelfState>(
                      builder: (context, state) {
                    if (state.status == TestYourSelfStatus.success) {
                      return showBtn(
                        screenWidth: screenWidth,
                        // students: state.students,
                      );
                    } else if (state.status == TestYourSelfStatus.failure) {
                      return CustomErrorWidget(
                          errorMessage: state.errorMessage!,
                          onRetry: () => context
                              .read<TestYourSelfCubit>()
                              .getTests(testsType: testType));
                    }
                    return Expanded(child: CustomCircualProgressIndicator());
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class showBtn extends StatelessWidget {
  const showBtn({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    ));
  }
}
