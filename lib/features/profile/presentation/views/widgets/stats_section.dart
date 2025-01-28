import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/styles.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('فيديوهات', '+15', Icon(Icons.watch_later_outlined)),
            _buildStatItem('العمر', '21', Icon(Icons.person_2_outlined)),
            _buildStatItem('مستوى', '+50', Icon(Icons.leaderboard_outlined)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String title, String value, Icon icon) {
    return Column(
      children: [
        CircleAvatar(
          maxRadius: 27,
          backgroundColor: AppColors.avatarColor,
          child: icon,
        ),
        SizedBox(
          height: 8,
        ),
        Text(title,
            style: Styles.textStyle18.copyWith(color: AppColors.textColor)),
        SizedBox(
          height: 15,
        ),
        Text(value,
            style: Styles.textStyle18.copyWith(color: AppColors.textColor)),
      ],
    );
  }
}
