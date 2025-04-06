import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:mk_academy/features/courses/data/repo/courses_repo.dart';
import 'package:mk_academy/features/courses/presentation/view_model/one%20course%20cubit/one_course_cubit.dart';
import 'package:mk_academy/features/courses/presentation/view_model/videos_cubit/videos_cubit.dart';
import 'package:mk_academy/features/courses/presentation/views/widgets/play_list_page.dart';

class CustomVideoDetailsSheet extends StatelessWidget {
  const CustomVideoDetailsSheet({super.key, required this.courseId});
  final int courseId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OneCourseCubit(getit.get<CoursesRepo>())
        ..getCourse(courseId: courseId),
      child: BlocBuilder<OneCourseCubit, OneCourseState>(
        builder: (context, state) {
          if (state.status == CourseStatus.failure) {
            return CustomErrorWidget(
                errorMessage: state.errorMessage!,
                onRetry: () => context
                    .read<OneCourseCubit>()
                    .getCourse(courseId: courseId));
          } else if (state.status == CourseStatus.success) {
            return Center(
              child: Column(
                children: [
                  Text(
                    state.course!.subject!,
                    style: Styles.textStyle20.copyWith(color: Colors.white),
                  ),
                  Text(
                    state.course!.courseMode!,
                    style: Styles.textStyle20.copyWith(color: Colors.white),
                  ),
                  Text(
                    state.course!.description!,
                    style: Styles.textStyle20.copyWith(color: Colors.white),
                  ),
                  Text(
                    "${state.course!.price.toString()} ${"sp".tr(context)}",
                    style: Styles.textStyle20.copyWith(color: Colors.white),
                  ),
                  CustomButton(
                      onPressed: () {
                        if (state.course!.can_show!) {
                          context
                              .read<VideosCubit>()
                              .getVideos(courseId: courseId);
                          Navigator.of(context).push(goRoute(
                              x: ShowPlayList(
                            courseId: courseId,
                          )));
                        } else {
                          // go to pay
                        }
                      },
                      child: Icon(state.course!.can_show!
                          ? Icons.play_arrow_outlined
                          : Icons.lock_outline))
                ],
              ),
            );
          }
          return Center(child: CustomCircualProgressIndicator());
        },
      ),
    );
  }
}
