class UserCourses {
  int? id;
  String? name;
  int? price;
  String? purchasedDate;

  UserCourses({this.id, this.name, this.price, this.purchasedDate});

  UserCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    purchasedDate = json['purchased_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['purchased_date'] = this.purchasedDate;
    return data;
  }
}
