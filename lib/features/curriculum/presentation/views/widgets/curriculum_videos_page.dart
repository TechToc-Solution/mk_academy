import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constats.dart';
import 'custom_video_item.dart';
import 'uint_number_container.dart';

class CurriculumVideosPage extends StatelessWidget {
  const CurriculumVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        children: [
          CustomAppBar(title: "curriculum".tr(context), back_btn: true),
          SizedBox(height: kSizedBoxHeight),
          UintNumberContainer(),
          SizedBox(height: kSizedBoxHeight),
          Divider(
            color: AppColors.primaryColors,
            thickness: 0.5,
          ),
          CustomVideoItem(),
          CustomVideoItem(),
          CustomVideoItem(),
        ],
      )),
    );
  }
}
