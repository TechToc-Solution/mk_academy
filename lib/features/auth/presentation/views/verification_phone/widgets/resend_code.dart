import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/styles.dart';

class ResendCode extends StatelessWidget {
  const ResendCode({
    super.key,
    required bool canResend,
    required int remainingTime,
    required this.onPressed,
  })  : _canResend = canResend,
        _remainingTime = remainingTime;

  final bool _canResend;
  final int _remainingTime;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "didn't_receive_code".tr(context),
          style: Styles.textStyle18.copyWith(color: Colors.white),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: onPressed,
          child: Text(
            _canResend
                ? "resend".tr(context)
                : "${"resend".tr(context)} (${_remainingTime.toString().padLeft(2, '0')})",
            style: TextStyle(
              color: _canResend ? AppColors.primaryColors : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
