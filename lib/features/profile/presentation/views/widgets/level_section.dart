import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../auth/presentation/views/widgets/custom_button.dart';

class LevelSection extends StatelessWidget {
  const LevelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kSizedBoxHeight),
          _buildLevelInfoItem('المستوى الحالي', 'مستوى 5'),
          _buildLevelInfoItem('نقاط الخبرة', '1500/2000 XP'),
          _buildProgressBar(1500 / 2000),
          SizedBox(height: 40),
          CustomButton(
            text: "كيف يمكنني زيادة المستوى",
            onPressed: () {},
            verticalHieght: KVerticalPadding,
            horizontalWidth: KHorizontalPadding,
            color: AppColors.primaryColors,
            textStyle: Styles.textStyle18.copyWith(
                color: AppColors.backgroundColor, fontWeight: FontWeight.w700),
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
              style: Styles.textStyle18
                  .copyWith(color: AppColors.ProfileTextColor)),
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
      backgroundColor: AppColors.ProfileAvatarColor,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColors),
      minHeight: 12,
      borderRadius: BorderRadius.circular(10),
    );
  }
}
