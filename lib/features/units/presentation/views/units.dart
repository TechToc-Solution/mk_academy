import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/subjects/subjects_cubit.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/courses/data/repo/courses_repo.dart';
import 'package:mk_academy/features/units/presentation/views/units_section.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_top_nav_bar.dart';

import '../../../../core/utils/services_locater.dart';
import '../../../courses/presentation/view_model/cubit/courses_cubit.dart';

// ignore: must_be_immutable
class UnitsPage extends StatefulWidget {
  UnitsPage({super.key, required this.courseTypeId});
  static const String routeName = '/units';
  int courseTypeId;
  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<subjectsCubit>().getSubjects();
    //context.read<CoursesCubit>().resetPagination();
    // context.read<CoursesCubit>().getCourses(
    //       courseTypeId: widget.courseTypeId,
    //       subjectId: 3,
    //     );
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
        child: BlocBuilder<subjectsCubit, subjectsState>(
          builder: (context, state) {
            if (state is getSubjectsError) {
              return CustomErrorWidget(
                  errorMessage: state.erroMsg,
                  onRetry: () => context.read<subjectsCubit>().getSubjects());
            } else if (state is getSubjectsSucess) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: KHorizontalPadding, vertical: KVerticalPadding),
                child: UintsPageBody(
                    courseTypeId: widget.courseTypeId,
                    tabController: _tabController,
                    subjects: state.subjectsData[0].subjects!),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

class UintsPageBody extends StatefulWidget {
  const UintsPageBody({
    super.key,
    required TabController tabController,
    required this.subjects,
    required this.courseTypeId,
  }) : _tabController = tabController;
  final List<Subjects> subjects;
  final TabController _tabController;
  final int courseTypeId;

  @override
  State<UintsPageBody> createState() => _uintsPageBodyState();
}

class _uintsPageBodyState extends State<UintsPageBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTopNavBar(
          subjects: widget.subjects,
          tabController: widget._tabController,
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
          controller: widget._tabController,
          children: [
            for (int i = 0; i < widget.subjects.length; i++)
              BlocProvider(
                create: (context) => CoursesCubit(getit.get<CoursesRepo>())
                  ..getCourses(
                    courseTypeId: widget.courseTypeId,
                    subjectId: widget.subjects[i].id!,
                  ),
                child: UnitsSection(
                  courseTypeId: widget.courseTypeId,
                  subjectId: widget.subjects[i].id!,
                ),
              ),
          ],
        ))
      ],
    );
  }
}
