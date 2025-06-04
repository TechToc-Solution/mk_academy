import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../views-model/profile_cubit.dart';
import 'widgets/update_profile/update_profile_page_body.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.sizeOf(context),
        child: SafeArea(
            child: CustomAppBar(
                title: "update_profile".tr(context), backBtn: true)),
      ),
      body: UpdateProfilePageBody(
        userModel: context.read<ProfileCubit>().userModel!,
      ),
    );
  }
}
