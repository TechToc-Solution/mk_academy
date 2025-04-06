import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/styles.dart';
import '../../../../core/shared/models/questions_model.dart';
import 'widgets/questions_test/aswer_option.dart';
import 'widgets/questions_test/progress_dots.dart';
import 'test_result_page.dart';
import 'dart:async';

import 'widgets/questions_test/timer_section.dart';

class QuestionsTestPage extends StatefulWidget {
  final List<Question> questions;
  final String? asnwerPath;
  const QuestionsTestPage(
      {super.key, required this.questions, this.asnwerPath});
  static const String routeName = 'questionsTest';

  @override
  QuestionsTestPageState createState() => QuestionsTestPageState();
}

class QuestionsTestPageState extends State<QuestionsTestPage> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswer;
  late Timer _timer;
  int _remainingTime = 0;
  int _totalMarks = 0;
  int _quizScore = 0;
  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    _remainingTime = widget.questions[_currentQuestionIndex].duration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() => _remainingTime--);
      } else {
        _timer.cancel();
        _handleTimeExpired();
      }
    });
  }

  void _handleTimeExpired() {
    _nextQuestion(false);
  }

  void _nextQuestion(bool answeredCorrectly) {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _quizScore += widget.questions[_currentQuestionIndex].marks;
          if (answeredCorrectly) {
            _totalMarks += widget.questions[_currentQuestionIndex].marks;
          }

          if (_currentQuestionIndex < widget.questions.length - 1) {
            _currentQuestionIndex++;
            _selectedAnswer = null;
            _initializeTimer();
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TestResultPage(
                          score: _totalMarks,
                          quizScore: _quizScore,
                          answerPath: widget.asnwerPath,
                        )));
          }
        });
      }
    });
  }

  void _onAnswerSelected(int index) {
    setState(() {
      _selectedAnswer = index;
      _timer.cancel();
    });

    final currentQuestion = widget.questions[_currentQuestionIndex];
    bool isCorrect = currentQuestion.options[index].isCorrect;
    _nextQuestion(isCorrect);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentQuestionIndex];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimerSection(timeLeft: _remainingTime),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  '${"question".tr(context)} ${_currentQuestionIndex + 1}',
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColors,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                currentQuestion.title,
                style: Styles.textStyle16.copyWith(
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentQuestion.options.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) => AnswerOption(
                  text: currentQuestion.options[index].title,
                  isSelected: _selectedAnswer == index,
                  isTrueAnswer: currentQuestion.options[index].isCorrect,
                  onTap: () => _onAnswerSelected(index),
                ),
              ),
              const SizedBox(height: 16),
              ProgressDots(
                totalQuestions: widget.questions.length,
                currentQuestionIndex: _currentQuestionIndex,
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  AssetsData.logoNoBg,
                  color: Colors.white,
                  height: 50,
                  width: 50,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
