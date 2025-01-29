import 'package:flutter/material.dart';

import '../../../../../../core/utils/colors.dart';

class ProgressDots extends StatelessWidget {
  const ProgressDots({
    super.key,
    required this.questions,
    required int currentQuestionIndex,
  }) : _currentQuestionIndex = currentQuestionIndex;

  final List<Map<String, dynamic>> questions;
  final int _currentQuestionIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        questions.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: index == _currentQuestionIndex
                ? AppColors.primaryColors
                : AppColors.avatarColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
