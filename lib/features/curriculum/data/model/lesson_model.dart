// lessons_model.dart
class LessonsModel {
  final List<Lesson> lessons;
  final bool hasNext;
  final int currentPage;
  final int totalPages;
  final int perPage;

  LessonsModel({
    required this.lessons,
    required this.hasNext,
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
  });

  factory LessonsModel.fromJson(Map<String, dynamic> json) {
    return LessonsModel(
      lessons: (json['data']['list'] as List)
          .map((lesson) => Lesson.fromJson(lesson))
          .toList(),
      hasNext: json['data']['has_next'] ?? false,
      currentPage: json['data']['current_page'] ?? 1,
      totalPages: json['data']['total_pages'] ?? 1,
      perPage: json['data']['per_page'] ?? 15,
    );
  }
}

class Lesson {
  final int id;
  final String name;
  final String path;
  final int questionsCount;
  final DateTime createdAt;

  Lesson({
    required this.id,
    required this.name,
    required this.path,
    required this.questionsCount,
    required this.createdAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      questionsCount: json['questions_count'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
