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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    return data;
  }
}
