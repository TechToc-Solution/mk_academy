import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.verticalHieght,
      required this.horizontalWidth,
      required this.color,
      this.textStyle,
      this.height});
  final String text;
  final void Function() onPressed;
  final double verticalHieght;
  final double horizontalWidth;
  final Color color;
  final TextStyle? textStyle;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalHieght, horizontal: horizontalWidth),
      child: MaterialButton(
        color: color,
        height: height ?? 45,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius)),
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle ?? Styles.textStyle15.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
