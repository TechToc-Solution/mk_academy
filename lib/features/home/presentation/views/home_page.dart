import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/styles.dart';

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: Styles.textStyle18.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(select: "Home"),
    );
  }
}
