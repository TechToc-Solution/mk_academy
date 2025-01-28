import 'package:flutter/material.dart';

import 'widgets/curriculum_page_body.dart';

class CurriculumPage extends StatelessWidget {
  const CurriculumPage({super.key});
  static const String routeName = "curriculum";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CurriculumPageBody(),
    );
  }
}
