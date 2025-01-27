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
          backgroundColor: AppColors.ProfileAvatarColor,
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
                style: Styles.textStyle25
                    .copyWith(color: AppColors.ProfileTextColor)),
            Text('21',
                style: Styles.textStyle18
                    .copyWith(color: AppColors.ProfileTextColor)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  size: 17,
                  color: AppColors.ProfileTextColor,
                  Icons.pin_drop_outlined,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("سوريا-دمشف",
                    style: Styles.textStyle16
                        .copyWith(color: AppColors.ProfileTextColor)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
