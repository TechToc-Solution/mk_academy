class SubjectsModel {
  List<SubjectsData>? subjectData;
  SubjectsModel({
    this.subjectData,
  });
  SubjectsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      subjectData = <SubjectsData>[];
      json['data'].forEach((v) {
        subjectData!.add(SubjectsData.fromJson(v));
      });
    }
  }
}

class SubjectsData {
  int? id;
  String? name;
  List<Subjects>? subjects;

  SubjectsData({this.id, this.name, this.subjects});

  SubjectsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  int? id;
  String? name;

  Subjects({this.id, this.name});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
