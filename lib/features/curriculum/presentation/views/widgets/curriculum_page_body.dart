// ignore: unused_import
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_top_nav_bar.dart';

import 'curriclum_uint_section.dart';

class CurriculumPageBody extends StatelessWidget {
  const CurriculumPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: Column(
            children: [
              CustomTopNavBar(),
              SizedBox(
                height: kSizedBoxHeight,
              ),
              customLevelBar(),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: kSizedBoxHeight,
                    ),
                    CurriculumUintSection(),
                    SizedBox(
                      height: kSizedBoxHeight,
                    ),
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
