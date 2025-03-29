import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/subjects/subjects_cubit.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';

import 'widgets/courses_page_body.dart';

// ignore: must_be_immutable
class CoursesPage extends StatefulWidget {
  CoursesPage({super.key, required this.courseTypeId});
  static const String routeName = '/units';
  int courseTypeId;
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<SubjectsCubit>().getSubjects();
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
        child: BlocBuilder<SubjectsCubit, SubjectsState>(
          builder: (context, state) {
            if (state is GetSubjectsError) {
              return CustomErrorWidget(
                  errorMessage: state.erroMsg,
                  onRetry: () => context.read<SubjectsCubit>().getSubjects());
            } else if (state is GetSubjectsSucess) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                child: CoursesPageBody(
                    courseTypeId: widget.courseTypeId,
                    tabController: _tabController,
                    subjects: state.subjectsData[0].subjects!),
              );
            }
            return CustomCircualProgressIndicator();
          },
        ),
      ),
    );
  }
}
