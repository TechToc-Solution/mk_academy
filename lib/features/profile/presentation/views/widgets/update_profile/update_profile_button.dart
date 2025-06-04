import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../../core/utils/functions.dart';
import '../../../../../../core/widgets/custom_circual_progress_indicator.dart';
import '../../../../../auth/data/models/city_model.dart';
import '../../../../../auth/presentation/views/widgets/custom_button.dart';
import '../../../params/update_profile_params.dart';
import '../../../views-model/profile_cubit.dart';

class UpdateProfileButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController dateController;
  final String? selectedCity;

  final City oldCity;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const UpdateProfileButton(
      {super.key,
      required this.formKey,
      required this.dateController,
      required this.selectedCity,
      required this.oldCity,
      required this.firstNameController,
      required this.lastNameController});

  @override
  Widget build(BuildContext context) {
    String? newCity = selectedCity;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          messages(context, "profile_updated".tr(context), Colors.green);
        }
        if (state is ProfileUpdateError) {
          messages(context, state.errorMsg, Colors.red);
        }
      },
      builder: (context, state) {
        return CustomButton(
          child: state is ProfileUpdateLoading
              ? CustomCircualProgressIndicator()
              : Text("update".tr(context)),
          onPressed: () {
            if (formKey.currentState!.validate() && selectedCity != null) {
              final DateTime? birthDate =
                  _parseDateFromController(dateController.text);
              if (birthDate == null) {
                messages(context, "date_not_valid".tr(context), Colors.red);
                return;
              }
              if (selectedCity == oldCity.name) {
                newCity = oldCity.id.toString();
              }
              context.read<ProfileCubit>().updateProfile(
                    UpdateProfileParams(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      birthDate: birthDate,
                      cityId: newCity!,
                    ),
                  );
            } else {
              messages(context, "please_enter_the_required_data".tr(context),
                  Colors.red);
            }
          },
        );
      },
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
