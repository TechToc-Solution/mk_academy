import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/colors.dart';

import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/styles.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final String? Function(String?)? validatorFun;

  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.text,
    this.validatorFun,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColors,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColors,
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              dayStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              todayBorder: BorderSide(
                color: AppColors.primaryColors,
                width: 1.5,
              ),
              headerHelpStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              yearStyle: TextStyle(
                color: AppColors.primaryColors,
                fontWeight: FontWeight.bold,
              ),
              dayForegroundColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey;
                }
                return Colors.black87;
              }),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.text = "${picked.year}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffF4F7FE),
          borderRadius: BorderRadius.circular(kBorderRadius)),
      padding: EdgeInsets.only(top: 8),
      margin: EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () => _selectDate(context),
        style: Styles.textStyle16.copyWith(color: Colors.black87),
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffB2B9C6)),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderSide: BorderSide.none,
          ),
          fillColor: const Color(0xffF4F7FE),
          filled: true,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        validator: validatorFun,
      ),
    );
  }
}
