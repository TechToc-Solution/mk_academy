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
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/back_ground_image.dart';

import 'widgets/tests_list/tests_list_veiw.dart';

class TestsListPage extends StatelessWidget {
  static const routeName = '/testList';
  const TestsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int testType = args?['testType'] ?? 0;
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
                  SizedBox(
                    height: kSizedBoxHeight,
                  ),
                  BlocBuilder<TestYourSelfCubit, TestYourSelfState>(
                      builder: (context, state) {
                    if (state is TestsLoading && state.isFirstFetch) {
                      return Expanded(child: CustomCircualProgressIndicator());
                    } else if (state is TestsError) {
                      return CustomErrorWidget(
                          errorMessage: state.errorMsg,
                          onRetry: () {
                            context.read<TestYourSelfCubit>().resetPagination();
                            context
                                .read<TestYourSelfCubit>()
                                .getTests(testsType: testType, loadMore: false);
                          });
                    }
                    return TestsListVeiw(
                      screenWidth: screenWidth,
                      testType: testType,
                    );
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
