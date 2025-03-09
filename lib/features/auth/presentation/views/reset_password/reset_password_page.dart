import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/auth/presentation/views/verification_phone/verification_phone_page.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_phone_field.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../../core/utils/assets_data.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});
  static const String routeName = "resetPassword";
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final PhoneController _phoneController;
  @override
  void initState() {
    _phoneController = PhoneController(
        initialValue: PhoneNumber(isoCode: IsoCode.SY, nsn: ""));
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            back_btn: true,
            title: "rest_password".tr(context),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: ListView(
              children: [
                SizedBox(height: size.height * 0.1),
                Image.asset(
                  color: Colors.white,
                  AssetsData.logoNoBg,
                  height: 150,
                  width: 200,
                ),
                const SizedBox(height: kSizedBoxHeight),
                Text(
                  "enter_phone_num_to_reset_pass".tr(context),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColors),
                ),
                const SizedBox(height: kSizedBoxHeight),
                CustomPhoneField(
                    controller: _phoneController,
                    text: "phone_num".tr(context)),
                const SizedBox(height: kSizedBoxHeight),
                CustomButton(
                    onPressed: () {
                      if (_phoneController.value.nsn.isNotEmpty &&
                          _phoneController.value.countryCode.isNotEmpty) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerificationPhonePage(
                                    phoneNumber: _phoneController.value.nsn)));
                      }
                    },
                    child: Text(
                      "continue".tr(context),
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.white),
                    ))
              ],
            ),
          )),
        ],
      )),
    );
  }
}
