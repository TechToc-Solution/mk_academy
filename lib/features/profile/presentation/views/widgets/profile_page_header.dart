import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/styles.dart';

class ProfilePageHeader extends StatelessWidget {
  const ProfilePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          maxRadius: 60,
          backgroundColor: AppColors.avatarColor,
          child: Text(
            "A",
            style: Styles.textStyle35,
          ),
        ),
        SizedBox(
          width: 25,
        ),
        Column(
          children: [
            Text('اسم المستخدم',
                style: Styles.textStyle25.copyWith(color: AppColors.textColor)),
            Text('21',
                style: Styles.textStyle18.copyWith(color: AppColors.textColor)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  size: 17,
                  color: AppColors.textColor,
                  Icons.pin_drop_outlined,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("سوريا-دمشف",
                    style: Styles.textStyle16
                        .copyWith(color: AppColors.textColor)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
