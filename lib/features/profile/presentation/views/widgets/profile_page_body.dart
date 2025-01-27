import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/level_section.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/profile_page_header.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/profile_tab_bar.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/stats_section.dart';
import 'package:mk_academy/features/profile/presentation/views/widgets/subscriptions_section.dart';

class ProfilePageBody extends StatefulWidget {
  @override
  _ProfilePageBodyState createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: "profile".tr(context), back_btn: false),
              SizedBox(height: kSizedBoxHeight),
              ProfilePageHeader(),
              SizedBox(height: kSizedBoxHeight),
              Divider(
                color: AppColors.primaryColors,
                height: kSizedBoxHeight,
                thickness: 0.5,
              ),
              SizedBox(height: kSizedBoxHeight),
              StatsSection(),
              SizedBox(height: kSizedBoxHeight),
              ProfileTabBar(tabController: _tabController),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SubscriptionsSection(),
                    LevelSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
