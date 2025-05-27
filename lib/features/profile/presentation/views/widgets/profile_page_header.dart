import 'package:flutter/material.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/styles.dart';

class ProfilePageHeader extends StatelessWidget {
  const ProfilePageHeader({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // _buildAvatar(userModel.firstName),
        // SizedBox(
        //   width: 25,
        // ),
        Column(
          children: [
            Text("${userModel.firstName} ${userModel.lastName}",
                style: Styles.textStyle25.copyWith(color: AppColors.textColor)),
            Text(userModel.birthdate!,
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
                Text(userModel.city!.name!,
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

// Widget _buildAvatar(String? name) {
//   return Container(
//     width: 120,
//     height: 120,
//     decoration: BoxDecoration(
//       color: AppColors.avatarColor,
//       shape: BoxShape.circle,
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black12,
//           blurRadius: 8,
//           offset: Offset(0, 4),
//         )
//       ],
//     ),
//     alignment: Alignment.center,
//     child: Text(
//       name?.isNotEmpty == true ? name![0].toUpperCase() : '?',
//       style: Styles.textStyle35.copyWith(color: Colors.black),
//     ),
//   );
// }
