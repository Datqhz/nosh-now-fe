import 'package:nosh_now_application/data/models/eater.dart';

class Location {
  int locationId;
  String locationName;
  String phone;
  String coordinator;
  bool defaultLocation;
  Eater? eater;
  Location(
      {required this.locationId,
      required this.locationName,
      required this.coordinator,
      required this.phone,
      required this.defaultLocation,
      this.eater});
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationId: json['id'],
      locationName: json['locationName'],
      phone: json['phone'],
      coordinator: json['coordinator'],
      defaultLocation: json['defaultLocation'],
      eater: json['eater'] != null ? Eater.fromJson(json['eater']) : null,
    );
  }
}
