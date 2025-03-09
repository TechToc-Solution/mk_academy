import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/styles.dart';

class CustomOptField extends StatelessWidget {
  const CustomOptField({
    super.key,
    required this.size,
    this.onSubmit,
  });

  final Size size;
  final void Function(String)? onSubmit;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: OtpTextField(
          onSubmit: onSubmit,
          borderColor: AppColors.primaryColors,
          focusedBorderColor: AppColors.primaryColors,
          cursorColor: AppColors.primaryColors,
          fieldWidth: size.width * 0.15,
          showFieldAsBox: true,
          numberOfFields: 6,
          borderRadius: BorderRadius.circular(kBorderRadius),
          textStyle: Styles.textStyle18.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
