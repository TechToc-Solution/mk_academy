import 'package:flutter/material.dart';

import '../../../../../core/utils/functions.dart';
import '../../../../units/presentation/views/widgets/custom_category_unit_btn.dart';
import 'curriculum_videos_page.dart';

class CurriculumUintSection extends StatelessWidget {
  const CurriculumUintSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 20,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 12 / 9,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return CustomCategoryUnitBtn(
            onTap: () =>
                Navigator.of(context).push(goRoute(x: CurriculumVideosPage())),
          );
        });
  }
}
