import 'package:flutter/material.dart';
import 'package:mk_academy/features/auth/presentation/views/register/widgets/register_page_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static const String routeName = '/RegisterPage';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterPageBody(),
    );
  }
}
