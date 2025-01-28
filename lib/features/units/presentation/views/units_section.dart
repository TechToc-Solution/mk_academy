import 'package:flutter/material.dart';
import 'package:mk_academy/features/show_unit/presentation/views/widgets/custom_video_units_btn.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_category_unit_btn.dart';

import '../../../../core/utils/functions.dart';
import '../../../show_unit/presentation/views/unit.dart';

class UnitsSection extends StatelessWidget {
  const UnitsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 5,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 12 / 9,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return index % 2 == 0
              ? CustomVideoUnitBtn()
              : CustomCategoryUnitBtn(
                  onTap: () => Navigator.of(context)
                      .push(goRoute(x: UnitPage(title: "نص تجريبي"))),
                );
        });
  }
}
