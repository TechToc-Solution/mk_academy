class StudentsLeaderboardData {
  List<StudentsLeaderboardModel>? students;
  bool? hasNext;
  int? currentPage;
  int? totalPages;
  int? perPage;

  StudentsLeaderboardData(
      {this.students,
      this.hasNext,
      this.currentPage,
      this.totalPages,
      this.perPage});

  StudentsLeaderboardData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      students = <StudentsLeaderboardModel>[];
      json['list'].forEach((v) {
        students!.add(StudentsLeaderboardModel.fromJson(v));
      });
    }
    hasNext = json['has_next'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (students != null) {
      data['list'] = students!.map((v) => v.toJson()).toList();
    }
    data['has_next'] = hasNext;
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['per_page'] = perPage;
    return data;
  }
}

class StudentsLeaderboardModel {
  int? id;
  String? name;
  String? level;

  StudentsLeaderboardModel({this.id, this.name, this.level});

  StudentsLeaderboardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['level'] = level;
    return data;
  }
}
