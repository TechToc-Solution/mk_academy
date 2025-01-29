import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'aswer_option.dart';
import 'progress_dots.dart';
import 'test_result_page.dart';
import 'dart:async';

import 'timer_section.dart';

class QuestionsTestPage extends StatefulWidget {
  const QuestionsTestPage({super.key});
  static const String routeName = 'testQuestions';

  @override
  _QuestionsTestPageState createState() => _QuestionsTestPageState();
}

class _QuestionsTestPageState extends State<QuestionsTestPage> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswer;
  late Timer _timer;
  int _remainingTime = 10;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'نص السؤال التوضيحي هنا',
      'answers': ['إجابة 1', 'إجابة 2', 'إجابة 3', 'إجابة 4'],
      'correctIndex': 1,
    },
    {
      'question': 'نص السؤال الطويل جدًا الذي يحتاج إلى مساحة عرض مناسبة',
      'answers': ['إجابة طويلة', 'إجابة متوسطة', 'إجابة قصيرة', 'إجابة'],
      'correctIndex': 2,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingTime = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() => _remainingTime--);
      } else {
        _timer.cancel();
        _nextQuestion(false);
      }
    });
  }

  void _nextQuestion(bool answeredCorrectly) {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_currentQuestionIndex < questions.length - 1) {
            _currentQuestionIndex++;
            _selectedAnswer = null;
            _startTimer();
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TestResultPage(score: answeredCorrectly ? 20 : 0)));
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
    bool isCorrect = index == questions[_currentQuestionIndex]['correctIndex'];
    _nextQuestion(isCorrect);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  'السؤال ${_currentQuestionIndex + 1}',
                  style: Styles.textStyle20.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColors),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                questions[_currentQuestionIndex]['question'],
                style: Styles.textStyle16.copyWith(
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: questions[_currentQuestionIndex]['answers'].length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) => AnswerOption(
                  text: questions[_currentQuestionIndex]['answers'][index],
                  isSelected: _selectedAnswer == index,
                  isTrueAnswer:
                      index == questions[_currentQuestionIndex]['correctIndex'],
                  onTap: () => _onAnswerSelected(index),
                ),
              ),
              const SizedBox(height: 16),
              ProgressDots(
                questions: questions,
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
