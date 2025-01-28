import 'package:flutter/material.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/test_your_self_page.dart';

import '../../../../core/utils/functions.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 64,
          ),
          Spacer(
            flex: 1,
          ),
          CustomDrawerBtn(),
          CustomDrawerBtn(),
          CustomDrawerBtn(),
          CustomDrawerBtn(),
          CustomDrawerBtn(),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class CustomDrawerBtn extends StatelessWidget {
  const CustomDrawerBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(goRoute(x: TestYourSelfPage())),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("تجريب"), Icon(Icons.image)],
        ),
      ),
    );
  }
}
