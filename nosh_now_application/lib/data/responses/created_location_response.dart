import 'package:nosh_now_application/data/responses/error_response.dart';

class CreateLocationResponse extends ErrorResponse {

  CreateLocationResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
  });

  factory CreateLocationResponse.fromJson(Map<dynamic, dynamic> json) {
    return CreateLocationResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
    );
  }
}
