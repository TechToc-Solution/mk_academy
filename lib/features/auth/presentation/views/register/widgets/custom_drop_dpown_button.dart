import 'package:flutter/material.dart';

import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/styles.dart';

class CustomDropdownButton extends StatelessWidget {
  final String text;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownButton({
    super.key,
    required this.text,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: DropdownButtonFormField<String>(
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
        ),
        value: value,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        icon: const Icon(Icons.arrow_drop_down),
        style: Styles.textStyle16.copyWith(color: Colors.black87),
      ),
    );
  }
}
