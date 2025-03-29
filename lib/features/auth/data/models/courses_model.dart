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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['purchased_date'] = purchasedDate;
    return data;
  }
}
