import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/constats.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../auth/presentation/views/widgets/custom_button.dart';
import '../../../../data/model/tests_model.dart';
import '../../questions_test_page.dart';

class TestDetailsContent extends StatelessWidget {
  final Tests details;
  const TestDetailsContent({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem(
              Icons.quiz_outlined, 'test_name'.tr(context), details.name, true),
          if (details.questionsCount != null)
            _buildDetailItem(Icons.format_list_numbered_outlined,
                'questions'.tr(context), '${details.questionsCount}', false),
          _buildDetailItem(Icons.summarize_outlined, 'total_marks'.tr(context),
              '${details.totalMarks}', false),
          if (details.subject != null)
            _buildDetailItem(Icons.question_answer_outlined,
                'subject'.tr(context), details.subject!, false),
          if (details.unit != null)
            _buildDetailItem(Icons.subject_outlined, 'unit'.tr(context),
                details.unit!, false),
          _buildActionButton(context),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
      IconData icon, String title, String value, bool underTilte) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kVerticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryColors),
              const SizedBox(width: 10),
              Text('$title: ',
                  style: Styles.textStyle16.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              if (!underTilte)
                Text(
                  value,
                  style:
                      Styles.textStyle16.copyWith(color: AppColors.avatarColor),
                ),
            ],
          ),
          if (underTilte)
            Text(
              value,
              style: Styles.textStyle16.copyWith(color: AppColors.avatarColor),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return CustomButton(
      onPressed: () {
        if (details.canSolve == true && details.questions != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => QuestionsTestPage(
                        questions: details.questions!,
                        asnwerPath: details.answer,
                      )));
        } else {
          // Handle purchase logic
        }
      },
      child: Text(
          details.canSolve == true
              ? 'start_test'.tr(context)
              : 'purchase_now'.tr(context),
          style: Styles.textStyle16.copyWith(color: Colors.white)),
    );
  }
}
