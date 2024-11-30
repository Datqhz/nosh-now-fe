
import 'package:management_app/data/responses/error_response.dart';

class LoginResponse extends ErrorResponse {
  LoginData? data;
  LoginResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory LoginResponse.fromJson(Map<dynamic, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null
    );
  }
}

class LoginData{
  String accessToken;
  String scope;
  int expired;
  
  LoginData({
    required this.accessToken, 
    required this.scope,
    required this.expired
  });

  factory LoginData.fromJson(Map<dynamic, dynamic> json) {
    return LoginData(
      accessToken: json['accessToken'],
      scope: json['scope'],
      expired: json['expired'],
    );
  }
}
