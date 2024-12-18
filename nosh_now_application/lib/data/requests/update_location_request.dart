class UpdateLocationRequest {
  int locationId;
  String locationName;
  String coordinate;
  String phone;

  UpdateLocationRequest({
    required this.locationName,
    required this.phone,
    required this.coordinate,
    required this.locationId
  });

  Map<String, dynamic> toJson() {
    return {
      'locationId': locationId,
      'locationName': locationName,
      'phone': phone,
      'coordinate': coordinate
    };
  }
}