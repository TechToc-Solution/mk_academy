import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/subjects/subjects_cubit.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/units/presentation/views/units_section.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_top_nav_bar.dart';

import '../../../courses/presentation/view_model/cubit/courses_cubit.dart';

class UnitsPage extends StatefulWidget {
  const UnitsPage({
    super.key,
  });
  static const String routeName = '/units';
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
    context.read<CoursesCubit>().resetPagination();
    context.read<CoursesCubit>().getCourses(
          courseTypeId: 1,
          subjectId: 1,
        );
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
                child: uintsPageBody(
                    tabController: _tabController,
                    subjectsData: state.subjectsData),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

class uintsPageBody extends StatelessWidget {
  const uintsPageBody({
    super.key,
    required TabController tabController,
    required this.subjectsData,
  }) : _tabController = tabController;
  final List<SubjectsData> subjectsData;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTopNavBar(
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
            UnitsSection(),
            UnitsSection(),
            UnitsSection(),
          ],
        ))
      ],
    );
  }
}
