import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../../../core/utils/assets_data.dart';
import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../view-model/register_cubit/register_cubit.dart';
import '../../verification_phone/verification_phone_page.dart';
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
                selectedCity = value;
              });
            },
          ),
          BlocConsumer<RegisterCubit, RegisterState>(builder: (context, state) {
            if (state is RegisterLoading) {
              return CustomButton(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  onPressed: () {});
            }
            return CustomButton(
                child: Text(
                  "confirm".tr(context),
                  style: Styles.textStyle15.copyWith(color: Colors.white),
                ),
                onPressed: () {
                  if (_registerFormKey.currentState!.validate() &&
                      selectedCity != null) {
                    final DateTime? birthDate =
                        parseDateFromController(dateController.text);
                    if (birthDate == null) {
                      messages(context, "تنسيق التاريخ غير صالح", Colors.red);
                      return;
                    }
                    context
                        .read<RegisterCubit>()
                        .register(getRegisterData(birthDate));
                  }
                });
          }, listener: (context, state) {
            if (state is RegisterError) {
              messages(context, state.errorMsg, Colors.red);
            }
            if (state is RegisterSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VerificationPhonePage(phoneNumber: state.phoneNum)));
            }
          }),
        ],
      ),
    );
  }

  DateTime? parseDateFromController(String dateString) {
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

  Map<String, dynamic> getRegisterData(DateTime birthDate) {
    final String formattedDate =
        formatDate(birthDate, [yyyy, '-', mm, '-', dd]);
    return {
      "phone":
          "+${phoneController.value.countryCode}${phoneController.value.nsn}",
      "password": passwordController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "city_id": selectedCity,
      "birthdate": formattedDate
    };
  }
}
