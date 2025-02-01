import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.back_btn,
  });
  final String title;
  final bool back_btn;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      decoration: BoxDecoration(
          color: AppColors.primaryColors,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          back_btn
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    size: 20,
                    color: AppColors.backgroundColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : SizedBox(
                  height: 50,
                  width: 50,
                ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 50,
            width: 50,
          ),
        ],
      ),
    );
  }
}
