import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/shimmer_container.dart';

import '../../../../../core/utils/functions.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../auth/presentation/views/login/login_page.dart';
import '../../../../courses/presentation/views/widgets/custom_category_unit_btn.dart';
import '../../views-model/curriculum_cubit.dart';
import '../curriculum_lessons_page.dart';

class CurriculumUnitsSection extends StatelessWidget {
  const CurriculumUnitsSection({super.key, required this.subjectId});
  final int subjectId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        if (state is UnitsSuccess) {
          return state.units.isEmpty
              ? Center(
                  child: Text(
                    "no_data".tr(context),
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : GridView.builder(
                  itemCount: state.units.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 12 / 9,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomCategoryUnitBtn(
                        unitText: state.units[index].name,
                        onTap: () {
                          if (isGuest) {
                            showCustomDialog(
                              context: context,
                              title: "req_login".tr(context),
                              description: "you_should_login".tr(context),
                              primaryButtonText: "login".tr(context),
                              onPrimaryAction: () {
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(
                                    context, LoginPage.routeName);
                              },
                            );
                          } else {
                            Navigator.of(context).push(goRoute(
                                x: CurriculumLessonsPage(
                              unit: state.units[index],
                            )));
                          }
                        });
                  });
        } else if (state is UnitsError) {
          return CustomErrorWidget(
            errorMessage: state.errorMsg,
            onRetry: () {
              context.read<CurriculumCubit>().getUnits(
                    subjectId: subjectId,
                  );
            },
          );
        }
        return Center(
          child: ShimmerContainer(),
        );
      },
    );
  }
}
