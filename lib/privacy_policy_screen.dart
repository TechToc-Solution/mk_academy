// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/features/auth/presentation/views/login/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool isChecked = false;

  final String policyUrl =
      'https://www.privacypolicies.com/live/62e59256-8310-4a96-a134-cafb9bdbe7e6';

  void _openPrivacyPolicy() async {
    if (await canLaunchUrl(Uri.parse(policyUrl))) {
      await launchUrl(Uri.parse(policyUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the privacy policy.')),
      );
    }
  }

  void _onContinue() async {
    await CacheHelper.setBool(key: 'firstTime', value: false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Spacer(),
              Lottie.asset(
                'assets/images/privacy.json',
                height: 300,
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                'privacy_title'.tr(context),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: _openPrivacyPolicy,
                child: Text(
                  'privacy_link'.tr(context),
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'privacy_checkbox'.tr(context),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              Spacer(
                flex: 2,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isChecked ? _onContinue : null,
                  child: Text('continue_button'.tr(context)),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
