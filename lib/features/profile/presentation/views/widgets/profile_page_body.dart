import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';
import 'package:mk_academy/features/auth/presentation/view-model/delete_account/delete_account_cubit.dart';
import 'package:mk_academy/features/auth/presentation/views/login/login_page.dart';
import 'package:mk_academy/features/home/presentation/views/drawer.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/level_section.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/profile_page_header.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/profile_tab_bar.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/stats_section.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/subscriptions_section.dart';

class ProfilePageBody extends StatefulWidget {
  final UserModel userModel;

  const ProfilePageBody({super.key, required this.userModel});
  @override
  ProfilePageBodyState createState() => ProfilePageBodyState();
}

class ProfilePageBodyState extends State<ProfilePageBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // update view when tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showDeleteDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: "warning".tr(context),
      description: "delete_account_warning".tr(context),
      primaryButtonText: "confirm".tr(context),
      secondaryButtonText: "cancel".tr(context),
      primaryButtonColor: Colors.red,
      secondaryButtonColor: Colors.green,
      onPrimaryAction: () => context.read<DeleteAccountCubit>().deleteAccount(),
      onSecondaryAction: Navigator.of(context).pop,
      icon: Icons.warning_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: kSizedBoxHeight),
            ProfilePageHeader(
              userModel: widget.userModel,
            ),
            SizedBox(height: kSizedBoxHeight / 2),
            BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
              listener: (context, state) {
                if (state is DeleteAccountSuccess) {
                  messages(
                      context, "account_deleted".tr(context), Colors.green);
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                }
                if (state is DeleteAccountError) {
                  messages(context, state.message, Colors.red);
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => _showDeleteDialog(context),
                  child: CustomDrawerBtn(
                    title: "delete_account".tr(context),
                    icon: Icons.delete,
                  ),
                );
              },
            ),
            Divider(
              color: AppColors.primaryColors,
              height: kSizedBoxHeight,
              thickness: 0.5,
            ),
            SizedBox(height: kSizedBoxHeight),
            StatsSection(
              userModel: widget.userModel,
            ),
            SizedBox(height: kSizedBoxHeight),
            ProfileTabBar(tabController: _tabController),
            IndexedStack(
              index: _tabController.index,
              children: [
                SubscriptionsSection(
                  courses: widget.userModel.courses ?? [],
                ),
                LevelSection(userModel: widget.userModel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
