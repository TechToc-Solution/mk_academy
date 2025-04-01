import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/enums.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'package:mk_academy/core/utils/validation.dart';
import 'package:mk_academy/core/widgets/custom_bottom_nav_bar.dart';
import 'package:mk_academy/features/auth/presentation/view-model/login_cubit/login_cubit.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_phone_field.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_text_filed.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../../../core/utils/colors.dart';
import 'singin_forget_password.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});
  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  late final TextEditingController nameController;
  late final TextEditingController passwordController;
  late final PhoneController phoneController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    phoneController = PhoneController(
        initialValue: PhoneNumber(isoCode: IsoCode.SY, nsn: ""));
    nameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        forceMaterialTransparency: true,
        title: Text("sing_in".tr(context)),
        titleTextStyle: Styles.textStyle18.copyWith(color: Colors.white),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding, vertical: kVerticalPadding),
        children: [
          SizedBox(
            height: kSizedBoxHeight,
          ),
          Image.asset(
            AssetsData.logoNoBg,
            color: Colors.white,
            height: 150,
            width: 200,
          ),
          SizedBox(
            height: kSizedBoxHeight,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "sing_in".tr(context),
              style: Styles.textStyle35
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          Form(
            key: _loginFormKey,
            child: Column(
              children: [
                CustomPhoneField(
                  controller: phoneController,
                  text: "phone_num".tr(context),
                ),
                CustomTextField(
                    text: "password".tr(context),
                    isPassword: true,
                    validatorFun: (p0) =>
                        Validator.validate(p0, ValidationState.normal),
                    controller: passwordController),
              ],
            ),
          ),
          SignUpForgetPassWidget(),
          BlocConsumer<LoginCubit, LoginState>(
            builder: (context, state) {
              return switch (state) {
                LoginLoading() => CustomButton(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                  ),
                _ => CustomButton(
                    onPressed: () {
                      if (_loginFormKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                            pass: passwordController.text,
                            phone:
                                "+${phoneController.value.countryCode}${phoneController.value.nsn}");
                      }
                    },
                    child: Text(
                      "login".tr(context),
                      style: Styles.textStyle15.copyWith(color: Colors.white),
                    ))
              };
            },
            listener: (BuildContext context, LoginState state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacementNamed(
                    context, CustomBottomNavBar.routeName);
              } else if (state is LoginError) {
                messages(context, state.errorMsg, Colors.red);
              }
            },
          ),
          SizedBox(
            height: kSizedBoxHeight,
          ),
          TextButton(
            child: Text("continue_without_login".tr(context),
                style: Styles.textStyle18.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 0.6,
                  decorationColor: AppColors.primaryColors,
                  color: AppColors.primaryColors,
                )),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, CustomBottomNavBar.routeName);
            },
          )
        ],
      ),
    );
  }
}
