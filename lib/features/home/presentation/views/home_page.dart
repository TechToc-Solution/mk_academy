import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/cubits/subjects/subjects_cubit.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../leaderboard/presentation/views-model/leaderboard_cubit.dart';
import '../views-model/ads/ads_cubit.dart';
import 'widgets/custom_home_shimmer.dart';
import 'widgets/home_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    onInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LeaderboardCubit, LeaderboardState>(
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
                    return CustomErrorWidget(
                      errorMessage: _getErrorMessage(
                          studentsState, subjectsState, adsState),
                      onRetry: () => onInit(context),
                    );
                  }
                  // Success State
                  else if (studentsState is LeaderboardSuccess &&
                      subjectsState is GetSubjectsSucess &&
                      adsState.status == AdsStatus.success) {
                    return HomePageBody(
                      students: studentsState.students,
                      subjects: subjectsState.subjectsData,
                      ads: adsState.ads,
                    );
                  }

                  // Loading State with Shimmer
                  return const CustomHomeShimmer();
                },
              );
            },
          );
        },
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

  void onInit(BuildContext context) {
    context.read<AdsCubit>().resetPagination();
    context.read<LeaderboardCubit>().getLeaderbord();
    context.read<SubjectsCubit>().getSubjects();
    context.read<AdsCubit>().getAds(adsType: 0);
  }
}
