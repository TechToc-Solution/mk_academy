import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/services_locater.dart';
import '../../../data/repos/login_repo/login_repo.dart';
import '../../view-model/login_cubit/login_cubit.dart';
import 'widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getit.get<LoginRepo>()),
      child: const Scaffold(
        body: LoginPageBody(),
      ),
    );
  }
}
