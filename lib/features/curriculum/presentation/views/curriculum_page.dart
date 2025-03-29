import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/subjects/subjects_cubit.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';

import 'widgets/curriculum_page_body.dart';

class CurriculumPage extends StatefulWidget {
  const CurriculumPage({super.key});
  static const String routeName = "curriculum";

  @override
  State<CurriculumPage> createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage> {
  @override
  void initState() {
    context.read<SubjectsCubit>().getSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<SubjectsCubit, SubjectsState>(builder: (context, state) {
      if (state is GetSubjectsSucess) {
        return CurriculumPageBody(
          subjects: state.subjectsData[0].subjects!,
        );
      }
      if (state is GetSubjectsError) {
        return CustomErrorWidget(
            errorMessage: state.erroMsg,
            onRetry: () {
              context.read<SubjectsCubit>().getSubjects();
            });
      }
      return CustomCircualProgressIndicator();
    }));
  }
}
