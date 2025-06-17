import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/auth/presentation/views/login/login_page.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:mk_academy/features/courses/data/repo/courses_repo.dart';
import 'package:mk_academy/features/courses/presentation/view_model/one%20course%20cubit/one_course_cubit.dart';
import 'package:mk_academy/features/courses/presentation/view_model/videos_cubit/videos_cubit.dart';
import 'package:mk_academy/features/courses/presentation/views/play_list_page.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../../core/shared/cubits/pay/pay_cubit.dart';
import '../../../../../core/shared/repos/pay/pay_repo.dart';
import '../../../../../core/widgets/custom_pay_dailog.dart';

class CustomVideoDetailsSheet extends StatefulWidget {
  const CustomVideoDetailsSheet(
      {super.key, required this.courseId, required this.canShow});
  final int courseId;
  final bool canShow;
  @override
  State<CustomVideoDetailsSheet> createState() =>
      _CustomVideoDetailsSheetState();
}

class _CustomVideoDetailsSheetState extends State<CustomVideoDetailsSheet> {
  bool hasError = false;

  double getProgress(int watched, int total) {
    if (total == 0) return 0.0;
    return watched / total.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OneCourseCubit(getit.get<CoursesRepo>())
        ..getCourse(courseId: widget.courseId),
      child: BlocBuilder<OneCourseCubit, OneCourseState>(
        builder: (context, state) {
          if (state.status == CourseStatus.failure) {
            return CustomErrorWidget(
                errorMessage: state.errorMessage!,
                onRetry: () => context
                    .read<OneCourseCubit>()
                    .getCourse(courseId: widget.courseId));
          } else if (state.status == CourseStatus.success) {
            final course = state.course!;
            final watched = course.viewed_videos_count;
            final total = course.total_videos;
            final progress = getProgress(watched!, total!);
            return Center(
              child: Column(
                children: [
                  _buildDetailItem(Icons.category, "subject".tr(context),
                      state.course!.subject!, false),
                  _buildDetailItem(Icons.mode, "type".tr(context),
                      state.course!.courseMode!, false),
                  _buildDetailItem(Icons.playlist_play, "videos".tr(context),
                      state.course!.total_videos.toString(), false),
                  if (state.course!.canShow!)
                    _buildDetailItem(
                        Icons.playlist_add_check,
                        "watched_videos".tr(context),
                        state.course!.viewed_videos_count.toString(),
                        false),
                  if (course.canShow!)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kVerticalPadding / 2, horizontal: 8),
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(16),
                        value: progress,
                        color: AppColors.primaryColors,
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                  _buildDetailItem(Icons.description, "description".tr(context),
                      state.course!.description ?? "", true),
                  if (!state.course!.canShow!)
                    _buildDetailItem(
                        Icons.attach_money,
                        "price".tr(context),
                        "${state.course!.price.toString()} ${"sp".tr(context)}",
                        false),
                  CustomButton(
                      onPressed: () {
                        if (isGuest) {
                          // messages(context, "you_should_login".tr(context),
                          //     Colors.red);
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, LoginPage.routeName);
                        } else if (state.course!.canShow!) {
                          context
                              .read<VideosCubit>()
                              .getVideos(courseId: widget.courseId);
                          Navigator.of(context).push(goRoute(
                              x: ShowPlayList(
                            courseId: widget.courseId,
                          )));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  PayCubit(GetIt.instance<PayRepo>()),
                              child: PaymentCodeDialog(
                                public: true,
                              ),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            isGuest
                                ? "login".tr(context)
                                : state.course!.canShow!
                                    ? "watch".tr(context)
                                    : "pay".tr(context),
                            style: Styles.textStyle16
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            isGuest
                                ? Icons.login
                                : state.course!.canShow!
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
          return Center(child: LinearProgressIndicator());
        },
      ),
    );
  }

  Widget _buildDetailItem(
      IconData icon, String title, String value, bool underTilte) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kVerticalPadding / 2, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryColors),
              const SizedBox(width: 10),
              Text('$title: ',
                  style: Styles.textStyle16.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              if (!underTilte)
                Html(
                  data: value,
                  style: {
                    "body": Style(
                        color: AppColors.avatarColor,
                        fontSize: FontSize(16.0),
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero),
                  },
                ),
            ],
          ),
          if (underTilte)
            Html(
              data: value,
              style: {
                "body": Style(
                    color: AppColors.avatarColor,
                    fontSize: FontSize(16.0),
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero),
              },
            ),
        ],
      ),
    );
  }
}
