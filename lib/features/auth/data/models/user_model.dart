import 'city_model.dart';
import 'courses_model.dart';

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? birthdate;
  int? points;
  int? maxPoints;
  String? level;
  int? age;
  City? city;
  List<UserCourses>? courses;
  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.birthdate,
      this.points,
      this.level,
      this.courses,
      this.age,
      this.maxPoints,
      this.city});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    birthdate = json['birthdate'];
    points = json['points'];
    level = json['level'];
    age = json['age'];
    maxPoints = json['max_points'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    if (json['courses'] != null) {
      courses = <UserCourses>[];
      json['courses'].forEach((v) {
        courses!.add(UserCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['birthdate'] = birthdate;
    data['points'] = points;
    data['level'] = level;
    data['age'] = age;
    data['max_points'] = maxPoints;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
