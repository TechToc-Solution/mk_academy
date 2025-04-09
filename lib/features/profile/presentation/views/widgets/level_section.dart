import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import '../../../../../core/utils/functions.dart';
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
          CustomLevelBar(
            showProfile: false,
          ),
          SizedBox(height: 8),
          CustomButton(
            onPressed: () => _showDeleteDialog(context),
            verticalHieght: kVerticalPadding,
            horizontalWidth: kHorizontalPadding,
            color: AppColors.primaryColors,
            textStyle: Styles.textStyle18.copyWith(
                color: AppColors.backgroundColor, fontWeight: FontWeight.w700),
            child: Text(
              "how_increase_level".tr(context),
              style: Styles.textStyle15
                  .copyWith(color: AppColors.textButtonColors),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showCustomDialog(
      oneButton: true,
      context: context,
      title: "increse_your_level".tr(context),
      description: "increse_level_msg".tr(context),
      primaryButtonText: "ok".tr(context),
      secondaryButtonText: "ok".tr(context),
      onPrimaryAction: () => {},
      icon: Icons.label_important_outline_rounded,
    );
  }
}
