import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';
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
            Divider(
              color: AppColors.primaryColors,
              height: kSizedBoxHeight,
              thickness: 0.5,
            ),
            SizedBox(height: kSizedBoxHeight),
            StatsSection(
              userModel: widget.userModel,
            ),
            Divider(
              color: AppColors.primaryColors,
              height: kSizedBoxHeight,
              thickness: 0.5,
            ),
            SizedBox(height: kSizedBoxHeight / 2),
            ProfileTabBar(tabController: _tabController),
            IndexedStack(
              index: _tabController.index,
              children: [
                SubscriptionsSection(
                  scroll: false,
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
