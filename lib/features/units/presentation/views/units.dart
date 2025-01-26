import 'package:flutter/material.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/units/presentation/views/units_section.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_top_nav_bar.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class UnitsPage extends StatefulWidget {
  const UnitsPage({super.key});
  static const String routeName = '/units';

  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {
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
          child: Column(
            children: [
              CustomTopNavBar(),
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
                  UnitsSection(),
                  SizedBox(
                    height: 16,
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
