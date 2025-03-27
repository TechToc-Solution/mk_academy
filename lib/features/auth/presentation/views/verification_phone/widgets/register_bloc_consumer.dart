import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';

import '../../../../../../core/utils/functions.dart';
import '../../../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../view-model/register_cubit/register_cubit.dart';
import '../../widgets/custom_button.dart';

class RegisterBlocConsumer extends StatelessWidget {
  const RegisterBlocConsumer({
    super.key,
    required this.theme,
    required String otpValue,
    required this.phoneNumber,
  }) : _otpValue = otpValue;

  final ThemeData theme;
  final String _otpValue;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        builder: (context, state) {
      if (state is VerifiPhoneLoading) {
        return CustomButton(
          child: Center(
            child: CustomCircualProgressIndicator(),
          ),
          onPressed: () {},
        );
      }
      return CustomButton(
        child: Text(
          "verfi_num".tr(context),
          style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        onPressed: () {
          if (_otpValue.isNotEmpty && _otpValue.length == 6) {
            context
                .read<RegisterCubit>()
                .verifiPhoneNum(phone: phoneNumber, code: _otpValue);
          }
        },
      );
    }, listener: (context, state) {
      if (state is VerifiPhoneError) {
        messages(context, state.errorMsg, Colors.red);
      }
      if (state is VerifiPhoneSuccess) {
        Navigator.pushReplacementNamed(context, CustomBottomNavBar.routeName);
      }
    });
  }
}
