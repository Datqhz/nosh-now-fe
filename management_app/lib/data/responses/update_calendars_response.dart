
import 'package:management_app/data/responses/error_response.dart';

class UpdateCalendarsResponse extends ErrorResponse {

  UpdateCalendarsResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode
  });

  factory UpdateCalendarsResponse.fromJson(Map<dynamic, dynamic> json) {
    return UpdateCalendarsResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}
