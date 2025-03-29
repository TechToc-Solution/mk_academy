import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/auth/presentation/views/reset_password/widgets/reset_password_bloc_consumer.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../../../core/utils/assets_data.dart';
import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/validation.dart';
import '../../widgets/custom_phone_field.dart';
import '../../widgets/custom_text_filed.dart';

class RestPasswordPageBody extends StatefulWidget {
  const RestPasswordPageBody({super.key});

  @override
  State<RestPasswordPageBody> createState() => _RestPasswordPageBodyState();
}

class _RestPasswordPageBodyState extends State<RestPasswordPageBody> {
  late final PhoneController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneController = PhoneController(
        initialValue: PhoneNumber(isoCode: IsoCode.SY, nsn: ""));
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Form(
          key: _formKey,
          child: ListView(
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
                "enter_phone_num_to_reset_pass".tr(context),
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColors,
                ),
              ),
              const SizedBox(height: kSizedBoxHeight),
              CustomPhoneField(
                controller: _phoneController,
                text: "phone_num".tr(context),
              ),
              CustomTextField(
                text: "new_password".tr(context),
                validatorFun: (p0) =>
                    Validator.validate(p0, ValidationState.password),
                isPassword: true,
                controller: _passwordController,
              ),
              CustomTextField(
                text: "confirm_password".tr(context),
                isPassword: true,
                validatorFun: (p0) => Validator.validateConfirmPassword(
                  p0,
                  _passwordController.text,
                ),
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: kSizedBoxHeight),
              ResetPasswordBlocConsumer(
                phoneController: _phoneController,
                formKey: _formKey,
                passwordController: _passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
