import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/enums.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'package:mk_academy/core/utils/validation.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_text_filed.dart';

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
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController = new TextEditingController();
    passwordController = new TextEditingController();
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
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
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
                CustomTextField(
                    text: "user_name".tr(context),
                    isPassword: false,
                    validatorFun: (p0) =>
                        Validator.validate(p0, ValidationState.normal),
                    controller: nameController),
                CustomTextField(
                    text: "password".tr(context),
                    isPassword: true,
                    validatorFun: (p0) =>
                        Validator.validate(p0, ValidationState.password),
                    controller: passwordController),
              ],
            ),
          ),
          SignUpForgetPassWidget(),
          CustomButton(
              text: "login".tr(context),
              onPressed: () {},
              verticalHieght: KHorizontalPadding,
              horizontalWidth: KVerticalPadding,
              color: AppColors.primaryColors)
        ],
      ),
    );
  }
}
