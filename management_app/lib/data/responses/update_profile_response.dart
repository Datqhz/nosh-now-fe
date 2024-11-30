
import 'package:management_app/data/responses/error_response.dart';

class UpdateProfileResponse extends ErrorResponse {

  UpdateProfileResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode
  });

  factory UpdateProfileResponse.fromJson(Map<dynamic, dynamic> json) {
    return UpdateProfileResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}
