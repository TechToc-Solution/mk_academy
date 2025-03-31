import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/auth/presentation/views/reset_password/reset_password_page.dart';

import '../../../../../../core/utils/styles.dart';
import '../../register/register_page.dart';

class SignUpForgetPassWidget extends StatelessWidget {
  const SignUpForgetPassWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButtonWidget(
          text: "sing_up".tr(context),
          onPressed: () {
            Navigator.pushNamed(context, RegisterPage.routeName);
          },
        ),
        CustomTextButtonWidget(
          text: "forgot_password".tr(context),
          onPressed: () {
            Navigator.pushNamed(context, ResetPasswordPage.routeName);
          },
        ),
      ],
    );
  }
}

class CustomTextButtonWidget extends StatelessWidget {
  const CustomTextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Styles.textStyle15.copyWith(
          decoration: TextDecoration.underline,
          decorationThickness: 0.6,
          decorationColor: Colors.white,
          color: Colors.white,
        ),
      ),
    );
  }
}
