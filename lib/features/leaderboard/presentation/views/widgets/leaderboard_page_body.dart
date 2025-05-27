import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/leaderboard/presentation/views/widgets/custom_leaderboard_show.dart';
import 'package:mk_academy/features/profile/presentation/views-model/profile_cubit.dart';

import '../../../../../core/utils/constats.dart';
import '../../../data/models/students_leaderboard_model.dart';
import 'leaderboard_section.dart';

class LeaderboardPageBody extends StatelessWidget {
  final List<StudentsLeaderboardModel> students;
  const LeaderboardPageBody({
    super.key,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: students.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: LeaderboardSection(
                        students: students,
                      ),
                    ),
                    if (!isGuest)
                      BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                        if (state is ProfileSuccess) {
                          if (!students.any(
                            (student) => student.id == state.userModel.id,
                          )) {
                            return CustomLeaderboardShow(
                                index: state.userModel.rank!,
                                students: StudentsLeaderboardModel(
                                    id: state.userModel.id,
                                    name:
                                        "${state.userModel.firstName} ${state.userModel.lastName!}",
                                    level: state.userModel.level),
                                isYou: true);
                          }
                        }
                        return SizedBox();
                      }),
                    SizedBox(
                      height: kSizedBoxHeight / 2,
                    )
                  ],
                )
              : SizedBox(
                  height: constraints.maxHeight,
                  child: Center(child: Text("no_data".tr(context))),
                ),
        );
      },
    );
  }
}
