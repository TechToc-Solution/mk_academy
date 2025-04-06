import '../../../../core/shared/models/questions_model.dart';

class TestsModel {
  List<Tests>? tests;
  bool? hasNext;
  int? currentPage;
  int? totalPages;
  int? perPage;

  TestsModel(
      {this.tests,
      this.hasNext,
      this.currentPage,
      this.totalPages,
      this.perPage});

  TestsModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      tests = <Tests>[];
      json['list'].forEach((v) {
        tests!.add(Tests.fromJson(v));
      });
    }
    hasNext = json['has_next'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    perPage = json['per_page'];
  }
}

class Tests {
  int id;
  String name;
  int? questionsCount;
  int totalMarks;
  String? unit;
  List<Question>? questions;
  bool? canSolve;
  String? answersFile;
  String? subject;
  String? answer;
  Tests(
      {required this.id,
      required this.name,
      this.questionsCount,
      required this.totalMarks,
      required this.unit,
      this.questions,
      this.canSolve,
      this.answersFile,
      this.subject,
      this.answer});

  factory Tests.fromJson(Map<String, dynamic> json) {
    return Tests(
        id: json['id'] as int,
        name: json['name'] as String,
        questionsCount: json.containsKey('questions_count')
            ? json['questions_count'] as int
            : null,
        totalMarks: json['total_marks'] as int,
        unit: json.containsKey('unit') ? json['unit'] as String? : null,
        questions: json.containsKey('questions')
            ? (json['questions'] as List)
                .map((q) => Question.fromJson(q))
                .toList()
            : null,
        canSolve: json['can_solve'] as bool?,
        answersFile: json['answers_file'] as String?,
        subject: json['subject'] as String?,
        answer: json.containsKey('answers_file') ? json['answers_file'] : null);
  }
}
