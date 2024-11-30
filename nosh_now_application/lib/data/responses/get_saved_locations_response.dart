import 'package:nosh_now_application/data/responses/error_response.dart';

class GetSavedLocationsResponse extends ErrorResponse {

  List<GetSavedLocationData>? data;
  GetSavedLocationsResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory GetSavedLocationsResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetSavedLocationsResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? (json['data'] as List).map((e) => GetSavedLocationData.fromJson(e)).toList(): null,
    );
  }
}


class GetSavedLocationData{
  int id;
  String name;
  String phone;
  String coordinate;
  
  GetSavedLocationData({
    required this.id, 
    required this.name,
    required this.phone,
    required this.coordinate
  });

  factory GetSavedLocationData.fromJson(Map<dynamic, dynamic> json) {
    return GetSavedLocationData(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      coordinate: json['coordinate']
    );
  }
}