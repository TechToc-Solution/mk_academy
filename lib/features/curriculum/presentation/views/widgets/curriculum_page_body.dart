// ignore: unused_import
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/features/curriculum/data/repos/curriculum_repo.dart';
import 'package:mk_academy/features/curriculum/presentation/views-model/curriculum_cubit.dart';
import 'package:mk_academy/core/widgets/custom_top_nav_bar.dart';

import '../../../../../core/shared/models/subjects_model.dart';
import '../../../../../core/utils/services_locater.dart';
import 'curriculum_units_section.dart';

class CurriculumPageBody extends StatelessWidget {
  const CurriculumPageBody({
    super.key,
    required TabController tabController,
    required this.subjects,
  }) : _tabController = tabController;
  final List<Subjects> subjects;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTopNavBar(
          isPrimary: false,
          subjects: subjects,
          tabController: _tabController,
        ),
        SizedBox(
          height: kSizedBoxHeight / 2,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              for (int i = 0; i < subjects.length; i++)
                BlocProvider(
                  create: (context) =>
                      CurriculumCubit(getit.get<CurriculumRepo>())
                        ..getUnits(
                          subjectId: subjects[i].id!,
                        ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CurriculumUnitsSection(
                      subjectId: subjects[i].id!,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
