import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class WhoWeAre extends StatelessWidget {
  const WhoWeAre({super.key});
  static String telegramUrl = "https://t.me/mkacademyapp";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: MediaQuery.sizeOf(context),
            child: SafeArea(
              child:
                  CustomAppBar(title: "who_we_are".tr(context), backBtn: true),
            )),
        body: Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text(
                'للتنويه:\n'
                'أرقام فريق الدعم التقني (واتساب + تلغرام):\n'
                '0994376448\n'
                '0954943107\n\n'
                'أرقام فريق الدعم الفني (واتساب + تلغرام):\n'
                '0948583508\n'
                '0962273814\n\n'
                'الرقم الذي يقوم بأرسال كود التحقق OTP غير مخصص للدعم',
                style: TextStyle(
                    fontSize: 16, height: 1.5, color: AppColors.textColor),
              ),
              CustomButton(
                  onPressed: () async {
                    if (await canLaunchUrl(Uri.parse(telegramUrl))) {
                      await launchUrl(Uri.parse(telegramUrl));
                    } else {
                      messages(context, 'error_link'.tr(context), Colors.red);
                    }
                  },
                  child: Text("telegram_url".tr(context)))
            ],
          ),
        ));
  }
}
