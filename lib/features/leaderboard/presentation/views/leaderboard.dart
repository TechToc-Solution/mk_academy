import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/leaderboard/data/repos/leaderboard_repo.dart';
import 'package:mk_academy/features/leaderboard/presentation/views-model/leaderboard_cubit.dart';

import 'widgets/leaderboard_page_body.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key, required this.backBtn});
  static const String routeName = '/leaderboard';
  final bool backBtn;
  @override
  State<LeaderboardPage> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaderboardCubit(getit.get<LeaderboardRepo>())
        ..getLeaderboard(loadMore: false),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: MediaQuery.sizeOf(context),
            child: SafeArea(
              child: CustomAppBar(
                  title: "the_order".tr(context), backBtn: widget.backBtn),
            )),
        body: BlocBuilder<LeaderboardCubit, LeaderboardState>(
            builder: (context, state) {
          if ((state is LeaderboardLoading && state.isFirstFetch) ||
              state is LeaderboardInitial) {
            return CustomCircualProgressIndicator();
          } else if (state is LeaderboardError) {
            return CustomErrorWidget(
                errorMessage: state.errorMsg,
                onRetry: () => context
                    .read<LeaderboardCubit>()
                    .getLeaderboard(loadMore: false));
          }
          return LeaderboardPageBody(
            students: context.read<LeaderboardCubit>().students,
          );
        }),
      ),
    );
  }
}
