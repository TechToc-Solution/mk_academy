import 'package:flutter/material.dart';
import '../../../../../core/utils/constats.dart';
import 'shimmer/ads_section_shimmer.dart';
import 'shimmer/category_section_shimmer.dart';
import 'shimmer/top_three_shimmer.dart';

class CustomHomeShimmer extends StatelessWidget {
  const CustomHomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: kSizedBoxHeight),
            const TopThreeShimmer(),
            const SizedBox(height: kSizedBoxHeight),
            const CategorySectionShimmer(),
            const SizedBox(height: kSizedBoxHeight),
            const AdsSectionShimmer(),
          ],
        ),
      ),
    );
  }
}
