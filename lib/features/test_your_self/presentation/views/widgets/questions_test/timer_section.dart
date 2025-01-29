import 'package:flutter/material.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/styles.dart';

class TimerSection extends StatelessWidget {
  final int timeLeft;
  const TimerSection({super.key, required this.timeLeft});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time, color: AppColors.primaryColors),
          const SizedBox(width: 8),
          Text('$timeLeft',
              style: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.textColor)),
        ],
      ),
    );
  }
}
