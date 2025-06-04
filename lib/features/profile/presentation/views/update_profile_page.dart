import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';

import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
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
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            messages(
                context, "update_profile_success".tr(context), Colors.green);
            context.read<ProfileCubit>().getProfile();
          }
          if (state is ProfileUpdateError) {
            messages(context, state.errorMsg, Colors.red);
          }
        },
        bloc: context.read<ProfileCubit>()..getProfile(),
        builder: (context, state) {
          if (state is ProfileSuccess) {
            return UpdateProfilePageBody(
              userModel: state.userModel,
            );
          } else if (state is ProfileError) {
            return CustomErrorWidget(
              errorMessage: state.errorMsg,
              onRetry: () {
                context.read<ProfileCubit>().getProfile();
              },
            );
          }
          return CustomCircualProgressIndicator();
        },
      ),
    );
  }
}
