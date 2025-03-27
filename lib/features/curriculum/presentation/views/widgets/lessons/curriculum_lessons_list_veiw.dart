import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/functions.dart';
import '../../../../data/model/lesson_model.dart';
import '../../../../data/model/units_model.dart';
import '../../../views-model/curriculum_cubit.dart';
import 'custom_lessons_item.dart';

class CurriculumLessonListView extends StatelessWidget {
  const CurriculumLessonListView(
      {super.key, required this.lessons, required this.unit});
  final List<Lesson> lessons;
  final Unit unit;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurriculumCubit>();
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        itemCount: lessons.length + (cubit.hasReachedMax ? 0 : 1),
        itemBuilder: (context, index) {
          if (index >= lessons.length) {
            if (!cubit.hasReachedMax) {
              cubit.getLessons(unit.id, loadMore: true);
            }
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
            );
          }
          return CustomLessonsItem(
            lesson: lessons[index],
            LessonNum: index + 1,
            onPressed: () => _handleVideoPlay(context, lessons[index]),
          );
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
