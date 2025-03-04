import 'package:flutter/material.dart';

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
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
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
