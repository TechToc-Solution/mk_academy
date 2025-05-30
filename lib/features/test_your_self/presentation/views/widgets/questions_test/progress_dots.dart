import 'package:flutter/material.dart';

import '../../../../../../core/utils/colors.dart';

class ProgressDots extends StatelessWidget {
  const ProgressDots({
    super.key,
    required int currentQuestionIndex,
    required int totalQuestions,
  })  : _currentQuestionIndex = currentQuestionIndex,
        _totalQuestions = totalQuestions;

  final int _currentQuestionIndex;
  final int _totalQuestions;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _totalQuestions,
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
