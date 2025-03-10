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
  List<Courses>? courses;
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
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['birthdate'] = this.birthdate;
    data['points'] = this.points;
    data['level'] = this.level;
    data['age'] = this.age;
    data['max_points'] = this.maxPoints;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
