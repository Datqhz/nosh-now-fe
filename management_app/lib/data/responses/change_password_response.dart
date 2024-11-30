
import 'package:management_app/data/responses/error_response.dart';

class ChangePasswordResponse extends ErrorResponse {

  ChangePasswordResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode
  });

  factory ChangePasswordResponse.fromJson(Map<dynamic, dynamic> json) {
    return ChangePasswordResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}
