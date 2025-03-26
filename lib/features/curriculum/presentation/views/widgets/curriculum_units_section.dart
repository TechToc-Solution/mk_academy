import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/widgets/shimmer_container.dart';

import '../../../../../core/utils/functions.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../units/presentation/views/widgets/custom_category_unit_btn.dart';
import '../../views-model/curriculum_cubit.dart';
import 'curriculum_videos_page.dart';

class CurriculumUnitsSection extends StatelessWidget {
  const CurriculumUnitsSection({super.key, required this.subjectId});
  final int subjectId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        if (state is UnitsSuccess) {
          return GridView.builder(
              itemCount: state.units.units.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 12 / 9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              itemBuilder: (BuildContext context, int index) {
                return CustomCategoryUnitBtn(
                  unitText: state.units.units[index].name,
                  onTap: () => Navigator.of(context)
                      .push(goRoute(x: CurriculumVideosPage())),
                );
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
