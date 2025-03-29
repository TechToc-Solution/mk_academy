import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../auth/presentation/views/widgets/custom_button.dart';

class LevelSection extends StatelessWidget {
  final UserModel userModel;
  const LevelSection({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kSizedBoxHeight),
          _buildLevelInfoItem("current_level".tr(context), userModel.level!),
          _buildLevelInfoItem('export_points'.tr(context),
              "${userModel.points}/${userModel.maxPoints}xp"),
          _buildProgressBar(userModel.points! / userModel.maxPoints!),
          SizedBox(height: 40),
          CustomButton(
            onPressed: () {},
            verticalHieght: kVerticalPadding,
            horizontalWidth: kHorizontalPadding,
            color: AppColors.primaryColors,
            textStyle: Styles.textStyle18.copyWith(
                color: AppColors.backgroundColor, fontWeight: FontWeight.w700),
            child: Text("how_increase_level".tr(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: Styles.textStyle18.copyWith(color: AppColors.textColor)),
          Text(value,
              style:
                  Styles.textStyle18.copyWith(color: AppColors.primaryColors)),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: AppColors.avatarColor,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColors),
      minHeight: 12,
      borderRadius: BorderRadius.circular(10),
    );
  }
}
