import 'package:flutter/material.dart';

class CustomCircualProgressIndicator extends StatelessWidget {
  const CustomCircualProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
