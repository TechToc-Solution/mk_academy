import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/home/presentation/views/advertising_section.dart';
import 'package:mk_academy/features/home/presentation/views/category_section.dart';
import 'package:mk_academy/features/home/presentation/views/drawer.dart';
import 'package:mk_academy/features/home/presentation/views/offers_section.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_advertising_item.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_top_3.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 8.0,
            right: 8.0,
          ),
          child: SliderDrawer(
            isDraggable: false,
            slideDirection: SlideDirection.rightToLeft,
            key: _sliderDrawerKey,
            backgroundColor: AppColors.backgroundColor,
            slider: CustomDrawer(),
            appBar: SizedBox(),
            child: Column(
              children: [
                CustomSearchBar(drawer_key: _sliderDrawerKey),
                SizedBox(
                  height: 8,
                ),
                customLevelBar(),
                Expanded(
                    child: ListView(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    CustomAdvertiseList(advertises: [
                      CustomTopThreeItem(),
                      CustomAdvertiseItem(),
                      CustomAdvertiseItem(),
                      CustomAdvertiseItem(),
                      CustomAdvertiseItem(),

                    ]),
                    SizedBox(
                      height: 8,
                    ),
                    CategorySection(),
                    OffersSection(),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
