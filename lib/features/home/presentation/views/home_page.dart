import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/features/home/presentation/views/drawer.dart';
import 'package:mk_academy/features/profile/presentation/views-model/profile_cubit.dart';

import '../../../../core/shared/cubits/solve_quizzes/solve_quizzes_cubit.dart';
import '../../../../core/shared/cubits/subjects/subjects_cubit.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_level_bar.dart';
import '../../../leaderboard/presentation/views-model/leaderboard_cubit.dart';
import '../views-model/ads/ads_cubit.dart';
import 'widgets/custom_home_shimmer.dart';
import 'widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  static const String routeName = '/home';
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SolveQuizzesCubit, SolveQuizzesState>(
      listener: (context, state) {
        if (state is AnswersSubmittedError) {
          messages(context, state.errorMsg, Colors.red);
        } else if (state is AnswersSubmittedSuccess) {
          messages(context, "تم حل الاختبار بنجاح", Colors.green);
          isGuest ? null : context.read<ProfileCubit>().getProfile();
          context.read<LeaderboardCubit>().getLeaderboard(loadMore: false);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPadding, vertical: kVerticalPadding),
            child: SliderDrawer(
              slideDirection:
                  Localizations.localeOf(context).languageCode == "ar"
                      ? SlideDirection.rightToLeft
                      : SlideDirection.leftToRight,
              isDraggable: false,
              key: _sliderDrawerKey,
              backgroundColor: AppColors.backgroundColor,
              slider: CustomDrawer(),
              appBar: SizedBox(),
              child: Column(
                children: [
                  HomeAppBar(sliderDrawerKey: _sliderDrawerKey),
                  BlocBuilder<LeaderboardCubit, LeaderboardState>(
                    builder: (context, studentsState) {
                      return BlocBuilder<SubjectsCubit, SubjectsState>(
                        builder: (context, subjectsState) {
                          return BlocBuilder<AdsCubit, AdsState>(
                            builder: (context, adsState) {
                              log("$studentsState, $subjectsState, $adsState");
                              // Error Handling
                              if (studentsState is LeaderboardError ||
                                  subjectsState is GetSubjectsError ||
                                  adsState.status == AdsStatus.failure) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: CustomErrorWidget(
                                    errorMessage: _getErrorMessage(
                                        studentsState, subjectsState, adsState),
                                    onRetry: () => onError(context),
                                  ),
                                );
                              }
                              // Success State
                              else if (studentsState is LeaderboardSuccess &&
                                  subjectsState is GetSubjectsSuccess &&
                                  adsState.status == AdsStatus.success) {
                                return Expanded(
                                  child: HomePageBody(
                                      students: studentsState.students,
                                      subjects: subjectsState.subjectsData,
                                      adsInt: adsState.adsInt,
                                      adsExt: adsState.adsExt),
                                );
                              }
                              // Loading State with Shimmer
                              return Expanded(child: const CustomHomeShimmer());
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getErrorMessage(
    LeaderboardState sState,
    SubjectsState subState,
    AdsState aState,
  ) {
    if (sState is LeaderboardError) return sState.errorMsg;
    if (subState is GetSubjectsError) return subState.erroMsg;
    if (aState.status == AdsStatus.failure) return aState.errorMessage!;
    return "هنالك خطأ ما,الرجاء المحاولة مجدداً";
  }

  void onError(BuildContext context) {
    context.read<AdsCubit>().resetPagination();
    context.read<LeaderboardCubit>().getLeaderboard(loadMore: false);
    context.read<SubjectsCubit>().getSubjects();
    context.read<AdsCubit>().getAllAds();
    isGuest ? null : context.read<ProfileCubit>().getProfile();
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required GlobalKey<SliderDrawerState> sliderDrawerKey,
  }) : _sliderDrawerKey = sliderDrawerKey;

  final GlobalKey<SliderDrawerState> _sliderDrawerKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryColors,
            ),
            child: IconButton(
                onPressed: () {
                  _sliderDrawerKey.currentState?.toggle(); // Open/close drawer
                },
                icon: Icon(Icons.list_outlined))),
        SizedBox(
          width: 8,
        ),
        if (!isGuest)
          Expanded(
              child: CustomLevelBar(
            compact: true,
            showProfile: false,
          )),
      ],
    );
  }
}
