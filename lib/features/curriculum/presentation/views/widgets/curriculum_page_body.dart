// ignore: unused_import
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_top_nav_bar.dart';

import 'curriclum_uint_section.dart';

class CurriculumPageBody extends StatefulWidget {
  const CurriculumPageBody({super.key});

  @override
  State<CurriculumPageBody> createState() => _CurriculumPageBodyState();
}

class _CurriculumPageBodyState extends State<CurriculumPageBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: Column(
            children: [
              CustomTopNavBar(
                tabController: _tabController,
              ),
              SizedBox(
                height: kSizedBoxHeight,
              ),
              customLevelBar(),
              SizedBox(
                height: kSizedBoxHeight,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    CurriculumUintSection(),
                    CurriculumUintSection(),
                    CurriculumUintSection(),
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
