import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/subscriptions_section.dart';

import '../../../../core/utils/constats.dart';
import '../views-model/profile_cubit.dart';

class UserSubscriptionsPage extends StatelessWidget {
  const UserSubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: MediaQuery.sizeOf(context),
          child: SafeArea(
              child: CustomAppBar(
                  title: "user_subscriptions".tr(context), backBtn: true)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: SubscriptionsSection(
              courses: context.read<ProfileCubit>().userModel!.courses ?? []),
        ));
  }
}
