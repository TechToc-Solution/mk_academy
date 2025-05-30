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
  String? image;
  List<Subjects>? subjects;

  SubjectsData({this.id, this.name, this.image, this.subjects});

  SubjectsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
