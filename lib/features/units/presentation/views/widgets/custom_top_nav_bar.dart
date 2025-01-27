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
          title: "جبر",
          index: 0,
        ),
        customTopNavBarBtn(
          title: "تحليل",
          index: 1,
        ),
        customTopNavBarBtn(
          title: "هندسة",
          index: 2,
        )
      ],
    );
  }
}
