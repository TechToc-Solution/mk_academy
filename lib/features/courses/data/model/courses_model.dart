class CoursesData {
  List<Courses>? courses;
  bool? hasNext;
  int? currentPage;
  int? totalPages;
  int? perPage;

  CoursesData(
      {this.courses,
      this.hasNext,
      this.currentPage,
      this.totalPages,
      this.perPage});

  CoursesData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      courses = <Courses>[];
      json['list'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
    hasNext = json['has_next'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['list'] = this.courses!.map((v) => v.toJson()).toList();
    }
    data['has_next'] = this.hasNext;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    data['per_page'] = this.perPage;
    return data;
  }
}

class Courses {
  int? id;
  String? name;
  String? description;
  int? price;
  String? createdAt;
  String? courseMode;
  String? image;

  Courses(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.createdAt,
      this.courseMode,
      this.image});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    createdAt = json['created_at'];
    courseMode = json['course_mode'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['course_mode'] = this.courseMode;
    data['image'] = this.image;
    return data;
  }
}
