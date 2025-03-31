class TestsData {
  List<Tests>? tests;
  bool? hasNext;
  int? currentPage;
  int? totalPages;
  int? perPage;

  TestsData(
      {this.tests,
      this.hasNext,
      this.currentPage,
      this.totalPages,
      this.perPage});

  TestsData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      tests = <Tests>[];
      json['list'].forEach((v) {
        tests!.add(new Tests.fromJson(v));
      });
    }
    hasNext = json['has_next'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (tests != null) {
      data['list'] = tests!.map((v) => v.toJson()).toList();
    }
    data['has_next'] = hasNext;
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['per_page'] = perPage;
    return data;
  }
}

class Tests {
  int? id;
  String? name;
  int? questionsCount;
  int? totalMarks;
  String? createdAt;
  String? unit;
  String? subject;

  Tests(
      {this.id,
      this.name,
      this.questionsCount,
      this.totalMarks,
      this.createdAt,
      this.unit,
      this.subject});

  Tests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    questionsCount = json['questions_count'];
    totalMarks = json['total_marks'];
    createdAt = json['created_at'];
    unit = json['unit'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['questions_count'] = questionsCount;
    data['total_marks'] = totalMarks;
    data['created_at'] = createdAt;
    data['unit'] = unit;
    data['subject'] = subject;
    return data;
  }
}
