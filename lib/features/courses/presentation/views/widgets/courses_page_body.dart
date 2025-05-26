import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/constats.dart';

import '../../../../../core/shared/models/subjects_model.dart';
import '../../../../../core/utils/services_locater.dart';
import '../../../data/repo/courses_repo.dart';
import '../../view_model/courses cubit/courses_cubit.dart';
import 'courses_units_section.dart';
import '../../../../../core/widgets/custom_top_nav_bar.dart';

class CoursesPageBody extends StatelessWidget {
  const CoursesPageBody({
    super.key,
    required TabController tabController,
    required this.subjects,
    required this.courseTypeId,
  }) : _tabController = tabController;
  final List<Subjects> subjects;
  final TabController _tabController;
  final int courseTypeId;

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
                create: (context) => CoursesCubit(getit.get<CoursesRepo>())
                  ..resetPagination()
                  ..getCourses(
                      courseTypeId: courseTypeId,
                      subjectId: subjects[i].id!,
                      loadMore: false),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CoursesUnitsSection(
                    courseTypeId: courseTypeId,
                    subjectId: subjects[i].id!,
                  ),
                ),
              ),
          ],
        )),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
