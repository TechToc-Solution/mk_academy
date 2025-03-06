import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../../../core/utils/assets_data.dart';
import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../view-model/register_cubit/register_cubit.dart';
import '../../widgets/custom_button.dart';
import 'register_form.dart';

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final PhoneController phoneController;
  late final TextEditingController dateController;
  String? selectedCity;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController = PhoneController(
        initialValue: PhoneNumber(isoCode: IsoCode.SY, nsn: ""));
    dateController = TextEditingController();
    context.read<RegisterCubit>().getCities();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        forceMaterialTransparency: true,
        foregroundColor: Colors.white,
        title: Text("sing_up".tr(context)),
        titleTextStyle: Styles.textStyle18.copyWith(color: Colors.white),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        children: [
          SizedBox(
            height: kSizedBoxHeight,
          ),
          Image.asset(
            color: Colors.white,
            AssetsData.logoNoBg,
            height: 150,
            width: 200,
          ),
          SizedBox(
            height: kSizedBoxHeight,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "sing_up".tr(context),
              style: Styles.textStyle35
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          RegisterForm(
            registerFormKey: _registerFormKey,
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
            phoneController: phoneController,
            dateController: dateController,
            selectedCity: selectedCity,
            onCityChanged: (value) {
              setState(() {
                print(value);
                selectedCity = value;
              });
            },
          ),
          CustomButton(
              child: Text(
                "confirm".tr(context),
                style: Styles.textStyle15.copyWith(color: Colors.white),
              ),
              onPressed: () {
                if (_registerFormKey.currentState!.validate() &&
                    selectedCity != null) {
                  print(dateController.text);
                  print(selectedCity);
                }
              },
              verticalHieght: KHorizontalPadding,
              horizontalWidth: KVerticalPadding,
              color: AppColors.primaryColors)
        ],
      ),
    );
  }
}
