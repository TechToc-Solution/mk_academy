import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.drawerKey,
  });
  final GlobalKey<SliderDrawerState> drawerKey;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryColors,
            ),
            child: IconButton(
                onPressed: () {
                  drawerKey.currentState?.toggle(); // Open/close drawer
                },
                icon: Icon(Icons.list_outlined))),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            height: 50,
            padding: EdgeInsets.only(top: 12, right: 16, left: 18, bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryColors),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "search".tr(context),
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
