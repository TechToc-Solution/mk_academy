import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/courses/presentation/view_model/cubit/courses_cubit.dart';
import 'package:mk_academy/features/show_unit/presentation/views/widgets/custom_video_units_btn.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_category_unit_btn.dart';

import '../../../../core/utils/functions.dart';
import '../../../show_unit/presentation/views/unit.dart';

// ignore: must_be_immutable
class UnitsSection extends StatefulWidget {
  UnitsSection(
      {super.key, required this.courseTypeId, required this.subjectId});
  int courseTypeId;
  int subjectId;
  @override
  State<UnitsSection> createState() => _UnitsSectionState();
}

class _UnitsSectionState extends State<UnitsSection> {
  @override
  void initState() {
    super.initState();
    context.read<CoursesCubit>().getCourses(
          courseTypeId: widget.courseTypeId,
          subjectId: widget.subjectId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        if (CoursesStatus.success == state.status)
          return GridView.builder(
              itemCount: 20,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 12 / 9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              itemBuilder: (BuildContext context, int index) {
                return index % 2 == 0
                    ? CustomVideoUnitBtn()
                    : CustomCategoryUnitBtn(
                        onTap: () => Navigator.of(context)
                            .push(goRoute(x: UnitPage(title: "نص تجريبي"))),
                      );
              });
        else if (CoursesStatus.failure == state.status)
          return ErrorWidget(state.errorMessage!);
        else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}
