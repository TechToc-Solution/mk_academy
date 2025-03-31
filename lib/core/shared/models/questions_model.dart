class Question {
  final int id;
  final String title;
  final int duration;
  final int marks;
  final int? optionId;
  final int? solveDuration;
  final bool isCorrect;
  final List<Option> options;

  Question({
    required this.id,
    required this.title,
    required this.duration,
    required this.marks,
    this.optionId,
    this.solveDuration,
    required this.isCorrect,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      marks: json['marks'],
      optionId: json['option_id'],
      solveDuration: json['solve_duration'],
      isCorrect: json['is_correct'] ?? false,
      options: (json['options'] as List)
          .map((option) => Option.fromJson(option))
          .toList(),
    );
  }
}

class Option {
  final int id;
  final String title;
  final bool isCorrect;

  Option({
    required this.id,
    required this.title,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      title: json['title'],
      isCorrect: json['is_correct'] == 1,
    );
  }
}
