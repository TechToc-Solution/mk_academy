class UnitsModel {
  final List<Unit> units;

  UnitsModel({required this.units});

  factory UnitsModel.fromJson(Map<String, dynamic> json) {
    return UnitsModel(
      units: (json['data'] as List).map((unit) => Unit.fromJson(unit)).toList(),
    );
  }
}

class Unit {
  final int id;
  final String name;

  Unit({required this.id, required this.name});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      name: json['name'],
    );
  }
}
