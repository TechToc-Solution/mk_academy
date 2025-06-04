import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/profile/presentation/views-model/profile_cubit.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'widgets/profile_page_body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileInitial) {
          context.read<ProfileCubit>().getProfile();
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: MediaQuery.sizeOf(context),
          child: SafeArea(
              child: CustomAppBar(title: "profile".tr(context), backBtn: true)),
        ),
        body: ProfilePageBody(
          userModel: context.read<ProfileCubit>().userModel!,
        ),
      ),
    );
  }
}
