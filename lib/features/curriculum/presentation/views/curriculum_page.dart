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
    context.read<subjectsCubit>().getSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<subjectsCubit, subjectsState>(builder: (context, state) {
      if (state is getSubjectsSucess) {
        return CurriculumPageBody(
          subjects: state.subjectsData[0].subjects!,
        );
      }
      if (state is getSubjectsError) {
        return CustomErrorWidget(
            errorMessage: state.erroMsg,
            onRetry: () {
              context.read<subjectsCubit>().getSubjects();
            });
      }
      return CustomCircualProgressIndicator();
    }));
  }
}
