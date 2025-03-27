import 'package:flutter/material.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../data/model/lesson_model.dart';
import '../../../../data/model/units_model.dart';
import 'curriculum_lessons_list_veiw.dart';
import '../uint_number_container.dart';

class CurriculumLessonsPageBody extends StatelessWidget {
  const CurriculumLessonsPageBody({
    super.key,
    required this.unit,
    required this.lessons,
  });

  final Unit unit;
  final List<Lesson> lessons;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kSizedBoxHeight),
        UintNumberContainer(
          unitNumber: unit.name,
        ),
        SizedBox(height: kSizedBoxHeight),
        Divider(
          color: AppColors.primaryColors,
          thickness: 0.5,
        ),
        if (lessons.isNotEmpty)
          CurriculumLessonListView(lessons: lessons, unit: unit),
        if (lessons.isEmpty)
          Center(
            child: Text(
              "لايوجد دروس حاليا!",
              style: Styles.textStyle18.copyWith(color: Colors.white),
            ),
          )
      ],
    );
  }
}
