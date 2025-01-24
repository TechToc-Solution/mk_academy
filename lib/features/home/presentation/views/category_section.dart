import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_category_list.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "categories".tr(context),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32),
            ),
            Text(
              "more".tr(context),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColors,
                  fontSize: 16),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 100,
          child: CustomCategoryList(),
        )
      ],
    );
  }
}
