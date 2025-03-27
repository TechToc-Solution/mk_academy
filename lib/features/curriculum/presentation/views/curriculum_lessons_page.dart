import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/curriculum/data/model/units_model.dart';
import 'package:mk_academy/features/curriculum/data/repos/curriculum_repo.dart';

import '../../../../core/utils/services_locater.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../views-model/curriculum_cubit.dart';
import 'widgets/lessons/curriculum_lessons_page_body.dart';

class CurriculumLessonsPage extends StatelessWidget {
  const CurriculumLessonsPage({super.key, required this.unit});
  final Unit unit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CurriculumCubit(getit.get<CurriculumRepo>())..getLessons(unit.id),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: MediaQuery.sizeOf(context),
          child: SafeArea(
              child: CustomAppBar(
                  title: "curriculum".tr(context), back_btn: true)),
        ),
        body: BlocBuilder<CurriculumCubit, CurriculumState>(
          builder: (context, state) {
            if ((state is LessonsLoading && state.isFirstFetch) ||
                state is CurriculumInitial) {
              return CustomCircualProgressIndicator();
            } else if (state is LessonsError) {
              return CustomErrorWidget(
                  errorMessage: state.errorMsg,
                  onRetry: () {
                    context.read<CurriculumCubit>().resetLessonsPagination();
                    context
                        .read<CurriculumCubit>()
                        .getLessons(unit.id, loadMore: false);
                  });
            }
            return CurriculumLessonsPageBody(
              unit: unit,
              lessons: context.read<CurriculumCubit>().lessons,
            );
          },
        ),
      ),
    );
  }
}
