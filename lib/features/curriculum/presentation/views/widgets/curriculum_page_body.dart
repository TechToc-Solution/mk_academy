// ignore: unused_import
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/curriculum/data/repos/curriculum_repo.dart';
import 'package:mk_academy/features/curriculum/presentation/views-model/curriculum_cubit.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_top_nav_bar.dart';

import '../../../../../core/shared/models/subjects_model.dart';
import '../../../../../core/utils/services_locater.dart';
import 'curriculum_units_section.dart';

class CurriculumPageBody extends StatefulWidget {
  const CurriculumPageBody({super.key, required this.subjects});
  final List<Subjects> subjects;
  @override
  State<CurriculumPageBody> createState() => _CurriculumPageBodyState();
}

class _CurriculumPageBodyState extends State<CurriculumPageBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: Column(
            children: [
              CustomTopNavBar(
                subjects: widget.subjects,
                tabController: _tabController,
              ),
              SizedBox(
                height: kSizedBoxHeight,
              ),
              customLevelBar(),
              SizedBox(
                height: kSizedBoxHeight,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    for (int i = 0; i < widget.subjects.length; i++)
                      BlocProvider(
                        create: (context) =>
                            CurriculumCubit(getit.get<CurriculumRepo>())
                              ..getUnits(
                                subjectId: widget.subjects[i].id!,
                              ),
                        child: CurriculumUnitsSection(
                          subjectId: widget.subjects[i].id!,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
