import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/auth/presentation/view-model/register_cubit/register_cubit.dart';

import '../../../../../core/utils/assets_data.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import '../../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import 'widgets/custom_opt_field.dart';
import 'widgets/resend_code.dart';
import 'widgets/verification_msg.dart';

class VerificationPhonePage extends StatefulWidget {
  const VerificationPhonePage({super.key, required this.phoneNumber});
  static const String routeName = "verificationPhone";
  final String phoneNumber;

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
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return Scaffold(
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
              resendCode(
                  onPressed: _canResend ? _resendCode : null,
                  canResend: _canResend,
                  remainingTime: _remainingTime),
              const SizedBox(height: kSizedBoxHeight),
              BlocConsumer<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                if (state is VerifiPhoneLoading) {
                  return CustomButton(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    onPressed: () {},
                  );
                }
                return CustomButton(
                  child: Text(
                    "verfi_num".tr(context),
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_otpValue.isNotEmpty && _otpValue.length == 6) {
                      context.read<RegisterCubit>().verifiPhoneNum(
                          phone: widget.phoneNumber, code: _otpValue);
                    }
                  },
                );
              }, listener: (context, state) {
                if (state is VerifiPhoneError) {
                  messages(context, state.errorMsg, Colors.red);
                }
                if (state is VerifiPhoneSuccess) {
                  Navigator.pushReplacementNamed(
                      context, CustomBottomNavBar.routeName);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
