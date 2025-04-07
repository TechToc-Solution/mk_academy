import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/features/leaderboard/presentation/views/widgets/custom_leaderboard_show.dart';

import '../../../data/models/students_leaderboard_model.dart';
import '../../views-model/leaderboard_cubit.dart';

class LeaderboardSection extends StatelessWidget {
  final List<StudentsLeaderboardModel> students;
  const LeaderboardSection({
    super.key,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LeaderboardCubit>();
    return ListView.builder(
        itemCount: students.length + (cubit.hasReachedMax ? 0 : 1),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index >= students.length) {
            if (!cubit.hasReachedMax) {
              context.read<LeaderboardCubit>().getLeaderboard(loadMore: true);
            }
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
            );
          }
          return CustomLeaderboardShow(
              index: index,
              students: students,
              isYou: CacheHelper.getData(key: "userId") ==
                  students[index].id.toString());
        });
  }
}
