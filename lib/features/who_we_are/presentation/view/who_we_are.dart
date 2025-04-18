import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          child: CustomAppBar(
            title: "who_we_are".tr(context),
            backBtn: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              "support_team".tr(context),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColors,
              ),
            ),
            const SizedBox(height: 16),

            // Support Team Contacts Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactInfo(
                      context,
                      Icons.phone,
                      "technical_team".tr(context),
                      ["0948583508", "0962273814"],
                    ),
                    const Divider(color: Colors.grey),
                    _buildContactInfo(
                      context,
                      Icons.phone,
                      "technical_support".tr(context),
                      ["0954943107", "0994376448", "0992981517"],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "otp_note".tr(context),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.backgroundColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Telegram Button
            CustomButton(
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse(telegramUrl))) {
                  await launchUrl(Uri.parse(telegramUrl));
                } else {
                  messages(
                    context,
                    'error_link'.tr(context),
                    Colors.red,
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.telegram, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    "telegram_url".tr(context),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(
    BuildContext context,
    IconData icon,
    String title,
    List<String> phoneNumbers,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primaryColors),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...phoneNumbers.map((number) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: number));
                  messages(context, "copied_to_clipboard".tr(context),
                      AppColors.primaryColors);
                },
                child: Row(
                  children: [
                    Icon(Icons.phone,
                        size: 16, color: AppColors.backgroundColor),
                    const SizedBox(width: 8),
                    Text(
                      number,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
