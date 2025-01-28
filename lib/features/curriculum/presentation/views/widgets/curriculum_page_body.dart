// ignore: unused_import
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_top_nav_bar.dart';

import 'curriclum_uint_section.dart';

class CurriculumPageBody extends StatelessWidget {
  const CurriculumPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          children: [
            CustomTopNavBar(),
            SizedBox(height: kSizedBoxHeight),
            CurriculumUintSection(),
          ],
        ),
      ),
    );
  }
}
