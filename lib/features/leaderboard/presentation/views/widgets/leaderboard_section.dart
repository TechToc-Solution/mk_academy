import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/features/leaderboard/presentation/views/widgets/custom_leaderboard_show.dart';

import '../../../data/models/students_leaderboard_model.dart';
import '../../views-model/leaderboard_cubit.dart';

class LeaderboardSection extends StatefulWidget {
  final List<StudentsLeaderboardModel> students;
  const LeaderboardSection({
    super.key,
    required this.students,
  });

  @override
  State<LeaderboardSection> createState() => _LeaderboardSectionState();
}

class _LeaderboardSectionState extends State<LeaderboardSection> {
  final _scrollController = ScrollController();
  late LeaderboardCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LeaderboardCubit>();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_cubit.hasReachedMax) {
        _cubit.getLeaderboard(loadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: widget.students.length + (_cubit.hasReachedMax ? 0 : 1),
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index >= widget.students.length) {
            if (!_cubit.hasReachedMax) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
              );
            }
          }
          return CustomLeaderboardShow(
              index: index,
              students: widget.students,
              isYou: CacheHelper.getData(key: "userId") ==
                  widget.students[index].id.toString());
        });
  }
}
