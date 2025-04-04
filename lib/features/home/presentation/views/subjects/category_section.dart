import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/features/home/presentation/views/subjects/all_subjects.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_category_list.dart';

import '../../../../../core/shared/models/subjects_model.dart';

class CategorySection extends StatelessWidget {
  final List<SubjectsData> subjects;
  const CategorySection({
    super.key,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "categories".tr(context),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AllSubjects.routeName),
              child: Text(
                "more".tr(context),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColors,
                    fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        if (subjects.isNotEmpty)
          SizedBox(
            height: 100,
            child: CustomCategoryList(
              subjectsData: subjects,
            ),
          )
        else
          Text("no_data".tr(context))
      ],
    );
  }
}
