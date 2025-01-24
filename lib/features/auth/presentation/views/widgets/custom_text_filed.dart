import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.borderColor,
    required this.text,
    required this.isPassword,
    this.maxLine = 1,
    required this.controller,
    this.validatorFun,
    this.keyboardType,
    this.onChange,
  });
  final String text;
  final bool isPassword;
  final int maxLine;
  final TextEditingController controller;
  final String? Function(String?)? validatorFun;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final void Function(String?)? onChange;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void dispose() {
    ;
    widget.controller.clear();
    super.dispose();
  }

  bool showPassowrd = false;
  FocusNode focusNode = FocusNode();
  Color fillColor = const Color(0xffF4F7FE);
  Color labelTextColor = Colors.black87;
  Color passwordIconColor = Colors.black87;
  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          fillColor = Colors.transparent;
          labelTextColor = Colors.white;
          passwordIconColor = AppColors.primaryColors;
        });
      } else {
        setState(() {
          labelTextColor = Colors.black87;
          fillColor = const Color(0xffF4F7FE);
          passwordIconColor = Colors.black87;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        style: Styles.textStyle16.copyWith(
          color: Colors.white,
        ),
        onChanged: widget.onChange,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.next,
        validator: widget.validatorFun,
        controller: widget.controller,
        focusNode: focusNode,
        maxLines: widget.maxLine,
        obscureText: widget.isPassword ? !showPassowrd : false,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: labelTextColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.borderColor == null
                    ? const Color(0xffB2B9C6)
                    : widget.borderColor!),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          labelText: widget.text,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    showPassowrd ? Icons.visibility : Icons.visibility_off,
                    color: passwordIconColor,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassowrd = !showPassowrd;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
              borderSide: BorderSide.none),
          fillColor: fillColor,
          filled: true,
        ),
      ),
    );
  }
}
