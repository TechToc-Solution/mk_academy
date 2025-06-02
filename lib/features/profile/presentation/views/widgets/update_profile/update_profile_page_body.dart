import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/auth/presentation/view-model/register_cubit/register_cubit.dart';

import '../../../../../../core/utils/functions.dart';
import '../../../../../auth/data/models/user_model.dart';
import '../../../../../auth/presentation/views/widgets/custom_button.dart';
import '../../../params/update_profile_params.dart';
import '../../../views-model/profile_cubit.dart';
import 'update_profile_form.dart';

class UpdateProfilePageBody extends StatefulWidget {
  const UpdateProfilePageBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<UpdateProfilePageBody> createState() => _UpdateProfilePageBodyState();
}

class _UpdateProfilePageBodyState extends State<UpdateProfilePageBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _dateController;
  String? selectedCity;
  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.userModel.firstName);
    _lastNameController =
        TextEditingController(text: widget.userModel.lastName);
    _dateController = TextEditingController();
    selectedCity = widget.userModel.city?.name;
    context.read<RegisterCubit>().getCities();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            UpdateProfileForm(
              formKey: _formKey,
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              dateController: _dateController,
              selectedCity: selectedCity,
              onCityChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
            ),
            CustomButton(
              child: Text("update".tr(context)),
              onPressed: () {
                if (_formKey.currentState!.validate() && selectedCity != null) {
                  final DateTime? birthDate =
                      _parseDateFromController(_dateController.text);
                  if (birthDate == null) {
                    messages(context, "date_not_valid".tr(context), Colors.red);
                    return;
                  }
                  if (selectedCity == widget.userModel.city?.name) {
                    selectedCity = widget.userModel.city?.id.toString();
                  }
                  context.read<ProfileCubit>().updateProfile(
                        UpdateProfileParams(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          birthDate: birthDate,
                          cityId: selectedCity!,
                        ),
                      );
                } else {
                  messages(context,
                      "please_enter_the_required_data".tr(context), Colors.red);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  DateTime? _parseDateFromController(String dateString) {
    try {
      final parts = dateString.split('/');
      if (parts.length != 3) return null;
      return DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
    } catch (e) {
      return null;
    }
  }
}
