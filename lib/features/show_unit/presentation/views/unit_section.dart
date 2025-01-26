import 'package:flutter/material.dart';
import 'package:mk_academy/features/show_unit/presentation/views/widgets/custom_video_units_btn.dart';

class UnitSection extends StatelessWidget {
  const UnitSection({
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
          return CustomVideoUnitBtn();
        });
  }
}
