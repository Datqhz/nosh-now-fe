
import 'package:management_app/data/models/restaurant_role.dart';
import 'package:management_app/data/responses/error_response.dart';

class GetEmployeesResponse extends ErrorResponse {

  List<GetEmployeesData>? data;
  GetEmployeesResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory GetEmployeesResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetEmployeesResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? (json['data'] as List).map((e) => GetEmployeesData.fromJson(e)).toList(): null,
    );
  }
}


class GetEmployeesData{
  String id;
  String displayName;
  String email;
  String phoneNumber;
  String avatar;
  RestaurantRole role;
  bool isActive;
  
  GetEmployeesData({
    required this.id, 
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.avatar,
    required this.role,
    required this.isActive
  });

  factory GetEmployeesData.fromJson(Map<dynamic, dynamic> json) {
    return GetEmployeesData(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      avatar: json['avatar'],
      role: RestaurantRole.values[json['role']],
      isActive: json['isActive']
    );
  }
}
