import 'package:flutter/material.dart';
import 'package:mk_academy/features/home/presentation/views/subjects/show_subject.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/category_item.dart';

import '../../../../../core/shared/models/subjects_model.dart';

class CustomCategoryList extends StatelessWidget {
  final List<SubjectsData> subjectsData;
  const CustomCategoryList({
    super.key,
    required this.subjectsData,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: subjectsData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, ShowSubSubjects.routeName,
                  arguments: {'subject': subjectsData[index]}),
              child: CategoryItem(
                subject: subjectsData[index],
              ),
            ),
          );
        });
  }
}
