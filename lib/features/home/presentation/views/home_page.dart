import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/home/presentation/views/advertising_section.dart';
import 'package:mk_academy/features/home/presentation/views/category_section.dart';
import 'package:mk_academy/features/home/presentation/views/offers_section.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_advertising_item.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_search_bar.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  static const String routeName = '/home';

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomSearchBar(),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  child: ListView(
                children: [
                  customLevelBar(),
                  SizedBox(
                    height: 8,
                  ),
                  CustomAdvertiseList(advertises: [
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
                ],
              ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(select: "Home"),
    );
  }
}
