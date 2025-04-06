import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/widgets/custom_buttom_sheet.dart';
import '../../../view_model/test_your_self_cubit.dart';
import '../subject_name_item.dart';
import 'test_details_bottom_sheet.dart';

class TestsListVeiw extends StatelessWidget {
  const TestsListVeiw({
    super.key,
    required this.screenWidth,
    required this.testType,
  });

  final double screenWidth;
  final int testType;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TestYourSelfCubit>();
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: kSizedBoxHeight),
      child: ListView.separated(
        itemCount: cubit.tests.length + (cubit.hasReachedMax ? 0 : 1),
        itemBuilder: (context, index) {
          if (index >= cubit.tests.length) {
            if (!cubit.hasReachedMax) {
              context
                  .read<TestYourSelfCubit>()
                  .getTests(testsType: testType, loadMore: true);
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
              );
            }
          }
          return SubjectNameItem(
            screenWidth: screenWidth,
            onTap: () {
              final testId = cubit.tests[index].id;

              CustomBottomSheet.show(
                context: context,
                heightFactor: 0.5,
                title: "test_details".tr(context),
                child: TestDetailsBottomSheet(testId: testId),
                backgroundColor: AppColors.backgroundColor,
              );
            },
            title: cubit.tests[index].name,
            questionsQount: cubit.tests[index].questionsCount,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: kSizedBoxHeight,
          );
        },
      ),
    ));
  }
}
