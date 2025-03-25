import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/assets_data.dart';

class CustomUserShow extends StatelessWidget {
  const CustomUserShow(
      {super.key,
      required this.title,
      required this.color,
      required this.level,
      required this.top});
  final int top;
  final String title;
  final Color color;
  final String level;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            top == 1
                ? AssetsData.medal1
                : top == 2
                    ? AssetsData.medal2
                    : AssetsData.medal3,
            height: 24,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            level.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
