import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/auth/presentation/view-model/delete_account/delete_account_cubit.dart';
import 'package:mk_academy/features/auth/presentation/view-model/register_cubit/register_cubit.dart';
import 'package:mk_academy/features/auth/presentation/views/login/login_page.dart';
import 'package:mk_academy/features/home/presentation/views/drawer.dart';
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

  void _showDeleteDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: "warning".tr(context),
      description: "delete_account_warning".tr(context),
      primaryButtonText: "confirm".tr(context),
      secondaryButtonText: "cancel".tr(context),
      primaryButtonColor: Colors.red,
      secondaryButtonColor: Colors.green,
      onPrimaryAction: () => context.read<DeleteAccountCubit>().deleteAccount(),
      onSecondaryAction: Navigator.of(context).pop,
      icon: Icons.warning_rounded,
    );
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
          BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
            listener: (context, state) {
              if (state is DeleteAccountSuccess) {
                messages(context, "account_deleted".tr(context), Colors.green);
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              }
              if (state is DeleteAccountError) {
                messages(context, state.message, Colors.red);
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () => _showDeleteDialog(context),
                child: CustomDrawerBtn(
                  title: "delete_account".tr(context),
                  icon: Icons.delete,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
