import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/auth/presentation/view-model/reset_password_cubit/reset_password_cubit.dart';
import 'package:mk_academy/features/auth/presentation/views/verification_phone/widgets/verfi_reset_passwrod_bloc_consumer.dart';

import '../../../../../core/utils/assets_data.dart';
import '../../../../../core/utils/colors.dart';

import '../../../../../core/utils/constats.dart';
import 'widgets/custom_opt_field.dart';
import 'widgets/register_bloc_consumer.dart';
import 'widgets/resend_code.dart';
import 'widgets/verification_msg.dart';

class VerificationPhonePage extends StatefulWidget {
  const VerificationPhonePage(
      {super.key, required this.phoneNumber, required this.fromRigster});
  static const String routeName = "verificationPhone";
  final String phoneNumber;
  final bool fromRigster;
  @override
  State<VerificationPhonePage> createState() => _VerificationPhonePageState();
}

class _VerificationPhonePageState extends State<VerificationPhonePage> {
  late Timer _timer;
  int _remainingTime = 60;
  bool _canResend = false;
  String _otpValue = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _canResend = false;
    _remainingTime = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() => _remainingTime--);
      } else {
        _timer.cancel();
        setState(() => _canResend = true);
      }
    });
  }

  void _resendCode() {
    if (_canResend) {
      if (!widget.fromRigster) {
        BlocProvider.of<ResetPasswordCubit>(context)
            .resendCode(phone: widget.phoneNumber);
      }

      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResendCodeSuccess) {
          messages(context, "success_code_send_agen".tr(context), Colors.green);
        } else if (state is ResetPasswordError) {
          messages(context, state.errorMsg, Colors.red);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.1),
                Image.asset(
                  color: Colors.white,
                  AssetsData.logoNoBg,
                  height: 150,
                  width: 200,
                ),
                const SizedBox(height: kSizedBoxHeight),
                Text(
                  "enter_the_code_to_continue".tr(context),
                  style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColors),
                ),
                const SizedBox(height: kSizedBoxHeight),
                VerificationMsg(phoneNumber: widget.phoneNumber),
                SizedBox(height: size.height * 0.05),
                CustomOptField(
                    size: size,
                    onSubmit: (value) {
                      setState(() => _otpValue = value);
                    }),
                const SizedBox(height: kSizedBoxHeight),
                ResendCode(
                    onPressed: _canResend ? _resendCode : null,
                    canResend: _canResend,
                    remainingTime: _remainingTime),
                const SizedBox(height: kSizedBoxHeight),
                if (widget.fromRigster)
                  RegisterBlocConsumer(
                      theme: theme,
                      otpValue: _otpValue,
                      phoneNumber: widget.phoneNumber),
                if (!widget.fromRigster)
                  VerfiResetPasswrodBlocConsumer(
                      theme: theme,
                      otpValue: _otpValue,
                      phoneNumber: widget.phoneNumber)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
