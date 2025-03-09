import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_phone_field.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/validation.dart';
import '../../widgets/custom_text_filed.dart';
import 'custom_date_picker.dart';
import 'custom_drop_dpown_button.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({
    super.key,
    required GlobalKey<FormState> registerFormKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.selectedCity,
    required this.dateController,
    required this.onCityChanged,
  }) : _registerFormKey = registerFormKey;

  final GlobalKey<FormState> _registerFormKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final PhoneController phoneController;
  final TextEditingController dateController;
  final String? selectedCity;
  final ValueChanged<String?> onCityChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: [
          CustomTextField(
            text: "first_name".tr(context),
            isPassword: false,
            validatorFun: (p0) =>
                Validator.validate(p0, ValidationState.normal),
            controller: firstNameController,
          ),
          CustomTextField(
            text: "last_name".tr(context),
            isPassword: false,
            validatorFun: (p0) =>
                Validator.validate(p0, ValidationState.normal),
            controller: lastNameController,
          ),
          CustomPhoneField(
              controller: phoneController, text: "phone_num".tr(context)),
          CustomDropdownButton(
            text: "city".tr(context),
            value: selectedCity,
            onChanged: (value) => onCityChanged,
            validator: (value) => value == null ? 'الرجاء اختيار مدينة' : null,
          ),
          CustomDatePicker(
            controller: dateController,
            text: "date_of_birth".tr(context),
            validatorFun: (value) =>
                value?.isEmpty ?? true ? 'الرجاء اختيار تاريخ' : null,
          ),
          CustomTextField(
              text: "password".tr(context),
              validatorFun: (p0) =>
                  Validator.validate(p0, ValidationState.password),
              isPassword: true,
              controller: passwordController),
          CustomTextField(
              text: "confirm_password".tr(context),
              isPassword: true,
              validatorFun: (p0) => Validator.validateConfirmPassword(
                  p0, passwordController.text),
              controller: confirmPasswordController),
        ],
      ),
    );
  }
}
