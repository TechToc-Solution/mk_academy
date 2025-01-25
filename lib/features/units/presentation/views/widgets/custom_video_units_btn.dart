import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';

class CustomVideoUnitBtn extends StatelessWidget {
  const CustomVideoUnitBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColors, width: 2),
            borderRadius: BorderRadius.circular(16),
            color: AppColors.backgroundColor,
          ),
          child: Center(
              child: Text(
            "Temp Text",
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          )),
        ),
        Container(
          padding: EdgeInsets.only(right: 8, bottom: 8),
          color: AppColors.backgroundColor,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: AppColors.primaryColors,
                borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.play_arrow_outlined),
          ),
        )
      ],
    );
  }
}
