class UpdateProfileParams {
  final String firstName;
  final String lastName;
  final String cityId;
  final DateTime birthDate;

  UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.cityId,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() => {
        '_method': 'PUT',
        'first_name': firstName,
        'last_name': lastName,
        'city_id': cityId,
        'birthdate': "${birthDate.year}-${birthDate.month}-${birthDate.day}",
      };
}
