class UnitsModel {
  final List<UnitModel> units;

  UnitsModel({required this.units});

  factory UnitsModel.fromJson(Map<String, dynamic> json) {
    return UnitsModel(
      units: (json['data'] as List)
          .map((unit) => UnitModel.fromJson(unit))
          .toList(),
    );
  }
}

class UnitModel {
  final int id;
  final String name;

  UnitModel({required this.id, required this.name});

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
