
import 'package:management_app/data/responses/error_response.dart';

class UpdateFoodResponse extends ErrorResponse {

  UpdateFoodResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode
  });

  factory UpdateFoodResponse.fromJson(Map<dynamic, dynamic> json) {
    return UpdateFoodResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}
