class Courses {
  int? id;
  String? name;
  int? price;
  String? purchasedDate;

  Courses({this.id, this.name, this.price, this.purchasedDate});

  Courses.fromJson(Map<String, dynamic> json) {
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
