// Add this to your widgets folder (test_details_bottom_sheet.dart)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/test_your_self/data/repo/tests_repo.dart';
import 'package:mk_academy/features/test_your_self/presentation/view_model/test_your_self_cubit.dart';

import '../../../../../../core/utils/colors.dart';
import 'test_details_content.dart';

class TestDetailsBottomSheet extends StatelessWidget {
  final int testId;
  const TestDetailsBottomSheet({super.key, required this.testId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TestYourSelfCubit(getit.get<TestsRepo>())..getTestDetails(testId),
      child: BlocBuilder<TestYourSelfCubit, TestYourSelfState>(
        builder: (context, state) {
          if (state is TestDetailsSuccess) {
            return TestDetailsContent(details: state.testDetails);
          } else if (state is TestDetailsError) {
            return CustomErrorWidget(
              errorMessage: state.errorMsg,
              textColor: Colors.black,
              onRetry: () =>
                  context.read<TestYourSelfCubit>().getTestDetails(testId),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColors,
            ),
          );
        },
      ),
    );
  }
}
