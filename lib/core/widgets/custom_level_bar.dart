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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "15 ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: LinearProgressIndicator(
          value: 1200 / 1500,
          backgroundColor: AppColors.avatarColor,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColors),
          minHeight: 12,
          borderRadius: BorderRadius.circular(10),
        )),
        Text(
          " 16",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
