// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomCircualProgressIndicator extends StatelessWidget {
  CustomCircualProgressIndicator({super.key, this.color = Colors.white});
  Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
