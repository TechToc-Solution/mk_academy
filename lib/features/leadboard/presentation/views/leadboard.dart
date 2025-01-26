import 'package:flutter/material.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/leadboard/presentation/views/leadboard_section.dart';

class LeadboardPage extends StatefulWidget {
  const LeadboardPage({super.key});
  static const String routeName = '/leadboard';

  @override
  State<LeadboardPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<LeadboardPage> {
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
              CustomAppBar(title: "الترتيب", back_btn: false),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  child: ListView(
                children: [
                  LeadboardSection(),
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
