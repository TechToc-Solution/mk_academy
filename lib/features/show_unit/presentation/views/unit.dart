import 'package:flutter/material.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/show_unit/presentation/views/unit_section.dart';

class UnitPage extends StatefulWidget {
  const UnitPage({super.key, required this.title});
  static const String routeName = '/unit';
  final String title;
  @override
  State<UnitPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitPage> {
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
              CustomAppBar(
                title: widget.title,
                back_btn: true,
              ),
              Expanded(
                  child: ListView(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  UnitSection(),
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
