import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/auth/presentation/view-model/register_cubit/register_cubit.dart';

import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../data/models/city_model.dart';

class CustomDropdownButton extends StatelessWidget {
  final String text;
  final String? value;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownButton({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffF4F7FE),
          borderRadius: BorderRadius.circular(kBorderRadius)),
      padding: EdgeInsets.only(top: 8),
      margin: EdgeInsets.symmetric(vertical: 16),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        builder: (context, state) {
          List<City> cities = context.read<RegisterCubit>().cities;
          return DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
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
            items: cities.map((value) {
              return DropdownMenuItem<String>(
                value: value.id.toString(),
                child: Text(value.name ?? ""),
              );
            }).toList(),
            onChanged: onChanged(value),
            validator: validator,
            icon: const Icon(Icons.arrow_drop_down),
            style: Styles.textStyle16.copyWith(color: Colors.black87),
          );
        },
        listener: (BuildContext context, RegisterState state) {
          if (state is GetCitiesError) {
            messages(context, state.errorMsg, Colors.red);
          }
        },
      ),
    );
  }
}
