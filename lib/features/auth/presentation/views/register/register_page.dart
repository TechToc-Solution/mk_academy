import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/auth/presentation/views/register/widgets/register_page_body.dart';

import '../../../../../core/utils/services_locater.dart';
import '../../../data/repos/register_repo/register_repo.dart';
import '../../view-model/register_cubit/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static const String routeName = '/register';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(getit.get<RegisterRepo>()),
        child: const Scaffold(
          body: RegisterPageBody(),
        ));
  }
}
