import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/questions_test_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/functions.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../data/model/lesson_model.dart';
import '../../../../data/model/units_model.dart';
import '../../../views-model/curriculum_cubit.dart';
import 'custom_lessons_item.dart';

class CurriculumLessonListView extends StatefulWidget {
  const CurriculumLessonListView(
      {super.key, required this.lessons, required this.unit});
  final List<Lesson> lessons;
  final Unit unit;

  @override
  State<CurriculumLessonListView> createState() =>
      _CurriculumLessonListViewState();
}

class _CurriculumLessonListViewState extends State<CurriculumLessonListView> {
  final _scrollController = ScrollController();
  late CurriculumCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CurriculumCubit>();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_cubit.hasReachedMax) {
        _cubit.getLessons(widget.unit.id, loadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurriculumCubit>();

    return Expanded(
      child: BlocConsumer<CurriculumCubit, CurriculumState>(
        builder: (context, state) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            itemCount: widget.lessons.length + (cubit.hasReachedMax ? 0 : 1),
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index >= widget.lessons.length) {
                if (!cubit.hasReachedMax) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
                  );
                }
              }
              final lesson = widget.lessons[index];
              Widget actionButton;
              if (state is LessonDetailsLoading &&
                  state.lessonId == lesson.id) {
                actionButton = const SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                );
              } else {
                actionButton = MaterialButton(
                  height: 25,
                  color: AppColors.primaryColors,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  onPressed: () => cubit.getLessonDetails(lesson.id),
                  child: Text(
                    "solve_quizes".tr(context),
                    style: Styles.textStyle13.copyWith(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }
              return CustomLessonsItem(
                lesson: lesson,
                lessonNum: index + 1,
                onPressed: () => _handleVideoPlay(context, lesson),
                actionButton: actionButton,
              );
            },
          );
        },
        listener: (BuildContext context, CurriculumState state) {
          if (state is LessonDetailsError) {
            messages(context, state.errorMsg, Colors.red);
          } else if (state is LessonDetailsSuccess) {
            if (state.lesson.questions == null ||
                state.lesson.questions!.isEmpty) {
              messages(context, "no_data".tr(context), Colors.grey);
            } else {
              bool canSolve = state.lesson.canSolve ?? false;
              if (canSolve) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionsTestPage(
                      questions: state.lesson.questions!,
                      quizId: state.lesson.id,
                      isCurriculumQuizz: true,
                    ),
                  ),
                );
              } else {
                messages(context, "quiz_solved".tr(context), Colors.grey);
              }
            }
          }
        },
      ),
    );
  }

  void _handleVideoPlay(BuildContext context, Lesson lesson) async {
    if (await canLaunchUrl(Uri.parse(lesson.path))) {
      await launchUrl(Uri.parse(lesson.path));
    } else {
      messages(context, 'could_not_launch_video'.tr(context), Colors.red);
    }
  }
}
