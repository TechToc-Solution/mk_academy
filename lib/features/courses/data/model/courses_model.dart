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
        courses!.add(Courses.fromJson(v));
      });
    }
    hasNext = json['has_next'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courses != null) {
      data['list'] = courses!.map((v) => v.toJson()).toList();
    }
    data['has_next'] = hasNext;
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['per_page'] = perPage;
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
  bool? canShow;
  String? subject;
  int? total_videos;
  int? viewed_videos_count;

  Courses(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.createdAt,
      this.courseMode,
      this.image,
      this.canShow,
      this.subject,
      this.total_videos,
      this.viewed_videos_count});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    createdAt = json['created_at'];
    courseMode = json['course_mode'];
    image = json['image'];
    canShow = json['can_show'];
    subject = json['subject'];
    total_videos = json['total_videos'];
    viewed_videos_count = json['viewed_videos_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['course_mode'] = courseMode;
    data['image'] = image;
    data['can_show'] = canShow;
    data['subject'] = subject;
    data['total_videos'] = total_videos;
    data['viewed_videos_count'] = viewed_videos_count;
    return data;
  }
}
