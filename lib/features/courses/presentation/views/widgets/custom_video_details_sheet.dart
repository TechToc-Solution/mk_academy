import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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

import '../../../../../core/shared/cubits/pay/pay_cubit.dart';
import '../../../../../core/shared/repos/pay/pay_repo.dart';
import '../../../../../core/widgets/custom_pay_dailog.dart';

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
                  CircleAvatar(
                    backgroundImage: NetworkImage(state.course!.image!),
                  ),
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
                        if (state.course!.canShow!) {
                          context
                              .read<VideosCubit>()
                              .getVideos(courseId: courseId);
                          Navigator.of(context).push(goRoute(
                              x: ShowPlayList(
                            courseId: courseId,
                          )));
                        } else {
                          // go to pay
                          showDialog(
                            context: context,
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  PayCubit(GetIt.instance<PayRepo>()),
                              child: PaymentCodeDialog(courseId: courseId),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.course!.canShow! ? "مشاهدة" : "شراء",
                            style: Styles.textStyle16
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            state.course!.canShow!
                                ? Icons.play_arrow_outlined
                                : Icons.payment_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ))
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
