import 'package:nosh_now_application/data/responses/error_response.dart';

class RegisterResponse extends ErrorResponse {
  RegisterResponse({
    required super.status,
    required super.statusText,
    required super.errorMessage,
    required super.errorMessageCode
  });
  factory RegisterResponse.fromJson(Map<dynamic, dynamic> json) {
    return RegisterResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}