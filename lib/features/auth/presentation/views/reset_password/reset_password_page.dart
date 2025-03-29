import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';

import 'widgets/reset_password_page_body.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});
  static const String routeName = "resetPassword";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            backBtn: true,
            title: "rest_password".tr(context),
          ),
          RestPasswordPageBody(),
        ],
      )),
    );
  }
}
