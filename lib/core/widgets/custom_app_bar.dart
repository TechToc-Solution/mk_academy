import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';

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
      decoration: BoxDecoration(
          color: AppColors.primaryColors,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          back_btn
              ? CircleAvatar(
                  backgroundColor: AppColors.avatarColor,
                  maxRadius: 20,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      size: 20,
                      color: AppColors.backgroundColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              : SizedBox(
                  width: 50,
                ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            width: 50,
          ),
        ],
      ),
    );
  }
}
