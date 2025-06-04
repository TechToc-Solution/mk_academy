import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/auth/presentation/view-model/register_cubit/register_cubit.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/update_profile/update_profile_button.dart';

import '../../../../../auth/data/models/user_model.dart';
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
          UpdateProfileButton(
            formKey: _formKey,
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
            dateController: _dateController,
            oldCity: widget.userModel.city!,
            selectedCity: selectedCity,
          ),
        ],
      ),
    );
  }
}
