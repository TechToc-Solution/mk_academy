import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

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
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RegisterPage.routeName);
          },
          child: Text("sing_up".tr(context),
              style: Styles.textStyle15.copyWith(
                decoration: TextDecoration.underline,
                decorationThickness: 0.6,
                decorationColor: Colors.white,
                color: Colors.white,
              )),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "forgot_password".tr(context),
            style: Styles.textStyle15.copyWith(
              decoration: TextDecoration.underline,
              decorationThickness: 0.6,
              decorationColor: Colors.white,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
