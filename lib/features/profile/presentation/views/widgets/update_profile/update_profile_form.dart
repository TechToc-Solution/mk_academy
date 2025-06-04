import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../auth/presentation/views/register/widgets/custom_date_picker.dart';
import '../../../../../auth/presentation/views/register/widgets/custom_drop_dpown_button.dart';
import '../../../../../auth/presentation/views/widgets/custom_text_filed.dart';

class UpdateProfileForm extends StatelessWidget {
  const UpdateProfileForm(
      {super.key,
      required this.formKey,
      required this.firstNameController,
      required this.lastNameController,
      required this.dateController,
      required this.selectedCity,
      required this.onCityChanged});
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController dateController;
  final String? selectedCity;
  final ValueChanged<String?> onCityChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: firstNameController,
              text: "first_name".tr(context),
              isPassword: false,
              validatorFun: (value) =>
                  Validator.validate(value!, ValidationState.normal),
            ),
            CustomTextField(
              controller: lastNameController,
              text: "last_name".tr(context),
              isPassword: false,
              validatorFun: (value) =>
                  Validator.validate(value!, ValidationState.normal),
            ),
            CustomDropdownButton(
              text: "city".tr(context),
              value: selectedCity,
              onChanged: (value) => onCityChanged,
              validator: (value) =>
                  value == null ? 'enter_the_required_city'.tr(context) : null,
            ),
            CustomDatePicker(
              controller: dateController,
              text: "date_of_birth".tr(context),
              validatorFun: (value) => value?.isEmpty ?? true
                  ? 'enter_the_required_data'.tr(context)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
