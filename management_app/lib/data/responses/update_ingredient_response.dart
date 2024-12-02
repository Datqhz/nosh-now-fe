import 'package:management_app/data/responses/error_response.dart';

class UpdateIngredientResponse extends ErrorResponse {

  UpdateIngredientResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode
  });

  factory UpdateIngredientResponse.fromJson(Map<dynamic, dynamic> json) {
    return UpdateIngredientResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}
