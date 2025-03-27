import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/features/auth/presentation/view-model/reset_password_cubit/reset_password_cubit.dart';
import 'package:mk_academy/features/auth/presentation/views/login/login_page.dart';

import '../../../../../../core/utils/functions.dart';
import '../../widgets/custom_button.dart';

class VerfiResetPasswrodBlocConsumer extends StatelessWidget {
  const VerfiResetPasswrodBlocConsumer(
      {super.key,
      required this.theme,
      required this.otpValue,
      required this.phoneNumber});
  final ThemeData theme;
  final String otpValue;
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
      if (state is ResetPasswordLoading) {
        return CustomButton(
          child: Center(child: CustomCircualProgressIndicator()),
          onPressed: () {},
        );
      }
      return CustomButton(
        child: Text(
          "verfi_num".tr(context),
          style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        onPressed: () {
          if (otpValue.isNotEmpty && otpValue.length == 6) {
            context
                .read<ResetPasswordCubit>()
                .verifyResetPassword(phone: phoneNumber, code: otpValue);
          }
        },
      );
    }, listener: (context, state) {
      if (state is ResetPasswordError) {
        messages(context, state.errorMsg, Colors.red);
      }
      if (state is VerifyResetPasswordSuccess) {
        messages(context, state.message, Colors.green);
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
  }
}
