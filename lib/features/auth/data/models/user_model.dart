import 'city_model.dart';

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? birthdate;
  int? points;
  String? level;
  City? city;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.birthdate,
      this.points,
      this.level,
      this.city});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    birthdate = json['birthdate'];
    points = json['points'];
    level = json['level'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
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
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}
