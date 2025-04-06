import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/styles.dart';

class StatsSection extends StatelessWidget {
  final UserModel userModel;
  const StatsSection({super.key, required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('age'.tr(context), "${userModel.age}",
                Icon(Icons.person_2_outlined)),
            _buildStatItem(
                'level'.tr(context), userModel.level!, Icon(Icons.upload)),
            _buildStatItem('rank'.tr(context), "${userModel.rank}",
                Icon(Icons.leaderboard)),
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
