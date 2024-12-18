class CreateLocationRequest {
  String name;
  String phone;
  String coordinate;

  CreateLocationRequest({
    required this.name,
    required this.phone,
    required this.coordinate
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'coordinate': coordinate
    };
  }
}