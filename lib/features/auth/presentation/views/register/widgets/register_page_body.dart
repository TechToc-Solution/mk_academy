import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../../core/utils/assets_data.dart';
import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/validation.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_filed.dart';

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {
  late final TextEditingController nameController;
  late final TextEditingController passwordContoller;
  late final TextEditingController confirnmPasswordController;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController = new TextEditingController();
    passwordContoller = new TextEditingController();
    confirnmPasswordController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordContoller.dispose();
    confirnmPasswordController.dispose();
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
          Form(
            key: _registerFormKey,
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
                    validatorFun: (p0) =>
                        Validator.validate(p0, ValidationState.password),
                    isPassword: true,
                    controller: passwordContoller),
                CustomTextField(
                    text: "confirm_password".tr(context),
                    isPassword: true,
                    validatorFun: (p0) => Validator.validateConfirmPassword(
                        p0, passwordContoller.text),
                    controller: confirnmPasswordController),
              ],
            ),
          ),
          CustomButton(
              text: "confirm".tr(context),
              onPressed: () {},
              verticalHieght: KHorizontalPadding,
              horizontalWidth: KVerticalPadding,
              color: AppColors.primaryColors)
        ],
      ),
    );
  }
}
