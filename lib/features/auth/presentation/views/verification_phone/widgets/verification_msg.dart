import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../../core/utils/colors.dart';

class VerificationMsg extends StatelessWidget {
  const VerificationMsg({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text.rich(
        TextSpan(
          text: "pleas_enter_the_number".tr(context),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.textColor,
          ),
          children: [
            TextSpan(
              text: phoneNumber,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColors,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
