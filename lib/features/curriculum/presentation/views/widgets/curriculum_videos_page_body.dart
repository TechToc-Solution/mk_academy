import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import '../../../../../core/utils/functions.dart';
import '../../../data/model/lesson_model.dart';
import '../../../data/model/units_model.dart';
import '../../views-model/curriculum_cubit.dart';
import 'custom_video_item.dart';
import 'uint_number_container.dart';

class CurriculumVideosPageBody extends StatelessWidget {
  const CurriculumVideosPageBody({
    super.key,
    required this.unit,
    required this.lessons,
  });

  final Unit unit;
  final List<Lesson> lessons;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurriculumCubit>();
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
        Expanded(
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
              return CustomVideoItem(
                lesson: lessons[index],
                onPressed: () => _handleVideoPlay(context, lessons[index]),
              );
            },
          ),
        )
      ],
    );
  }

  void _handleVideoPlay(BuildContext context, Lesson lesson) async {
    if (await canLaunchUrl(Uri.parse(lesson.path))) {
      await launchUrl(Uri.parse(lesson.path));
    } else {
      messages(context, 'Could not launch video', Colors.red);
    }
  }
}
