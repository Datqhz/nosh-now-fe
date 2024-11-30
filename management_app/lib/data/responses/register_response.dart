
import 'package:management_app/data/responses/error_response.dart';

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