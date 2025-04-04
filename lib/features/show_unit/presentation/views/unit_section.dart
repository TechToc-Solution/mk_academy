import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/core/widgets/shimmer_container.dart';
import 'package:mk_academy/features/courses/presentation/view_model/courses%20cubit/courses_cubit.dart';
import 'package:mk_academy/features/courses/presentation/views/widgets/custom_video_units_btn.dart';

class UnitSection extends StatefulWidget {
  const UnitSection({super.key, required this.subjectId});
  final int subjectId;
  @override
  State<UnitSection> createState() => _UnitSectionState();
}

class _UnitSectionState extends State<UnitSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        if (CoursesStatus.success == state.status) {
          return state.courses.isEmpty
              ? Center(
                  child: Text("no_data".tr(context),
                      style: TextStyle(color: Colors.white)),
                )
              : GridView.builder(
                  itemCount: state.courses.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 12 / 9,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomVideoUnitBtn(course: state.courses[index]);
                  });
        } else if (CoursesStatus.failure == state.status) {
          return CustomErrorWidget(
            errorMessage: state.errorMessage!,
            onRetry: () {
              context.read<CoursesCubit>().resetPagination();
              context.read<CoursesCubit>().getCourses(
                    courseTypeId: null,
                    subjectId: widget.subjectId,
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
