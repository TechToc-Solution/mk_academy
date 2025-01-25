import 'package:flutter/material.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_top_nav_bar_btn.dart';

class CustomTopNavBar extends StatelessWidget {
  const CustomTopNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customTopNavBarBtn(
          title: "unit1",
          index: 0,
        ),
        customTopNavBarBtn(
          title: "unit2",
          index: 1,
        ),
        customTopNavBarBtn(
          title: "unit3",
          index: 2,
        )
      ],
    );
  }
}
