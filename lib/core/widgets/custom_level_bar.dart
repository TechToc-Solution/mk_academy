import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';

class customLevelBar extends StatelessWidget {
  const customLevelBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "current_level".tr(context) + ": ",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "15 ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Divider(
            endIndent: 30,
            thickness: 5,
            color: AppColors.primaryColors,
          ),
        ),
        Text(
          "16",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
