import 'package:flutter/material.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/styles.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isTrueAnswer;
  const AnswerOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.isTrueAnswer,
  });

  @override
  Widget build(BuildContext context) {
    Color fillColor = isTrueAnswer ? Colors.green : Colors.red;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? fillColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? fillColor : AppColors.avatarColor,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: AppColors.avatarColor,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: Styles.textStyle16.copyWith(
                  color: isSelected
                      ? AppColors.textColor
                      : AppColors.backgroundColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
