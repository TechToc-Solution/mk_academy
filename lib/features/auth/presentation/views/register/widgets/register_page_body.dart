import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../../core/utils/assets_data.dart';
import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_filed.dart';

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {
  late final TextEditingController nameContrroler;
  late final TextEditingController passwordContrroler;
  late final TextEditingController ConfirnmPassword;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameContrroler = new TextEditingController();
    passwordContrroler = new TextEditingController();
    ConfirnmPassword = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameContrroler.dispose();
    passwordContrroler.dispose();
    ConfirnmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        children: [
          SizedBox(
            height: kSizedBoxHeight,
          ),
          Image.asset(
            AssetsData.logo,
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
                    controller: nameContrroler),
                CustomTextField(
                    text: "password".tr(context),
                    isPassword: true,
                    controller: passwordContrroler),
                CustomTextField(
                    text: "confirm_password".tr(context),
                    isPassword: true,
                    controller: passwordContrroler),
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
