import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../../../core/utils/functions.dart';
import '../../../view-model/reset_password_cubit/reset_password_cubit.dart';
import '../../verification_phone/verification_phone_page.dart';
import '../../widgets/custom_button.dart';

class ResetPasswordBlocConsumer extends StatelessWidget {
  final PhoneController phoneController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const ResetPasswordBlocConsumer({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        if (state is ResetPasswordLoading) {
          return CustomButton(
            onPressed: () {},
            child: Center(
              child: CustomCircualProgressIndicator(),
            ),
          );
        }
        return CustomButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<ResetPasswordCubit>().password =
                  passwordController.text;
              context.read<ResetPasswordCubit>().resetPassword(
                    phone:
                        "+${phoneController.value.countryCode}${phoneController.value.nsn}",
                  );
            }
          },
          child: Text(
            "continue".tr(context),
            style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
        );
      },
      listener: (context, state) {
        if (state is ResetPasswordError) {
          messages(context, state.errorMsg, Colors.red);
        }
        if (state is ResetPasswordSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationPhonePage(
                fromRigster: false,
                phoneNumber: state.phone,
              ),
            ),
          );
        }
      },
    );
  }
}
