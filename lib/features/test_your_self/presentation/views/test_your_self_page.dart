import 'package:flutter/material.dart';

import 'widgets/test_your_self_page_body.dart';

class TestYourSelfPage extends StatelessWidget {
  const TestYourSelfPage({super.key});
  static const String routeName = 'testYourSelf';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TestYourSelfPageBody(),
    );
  }
}
