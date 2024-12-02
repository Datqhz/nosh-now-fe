
import 'package:management_app/data/responses/error_response.dart';

class CreateIngredientResponse extends ErrorResponse {

  int? data;
  CreateIngredientResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory CreateIngredientResponse.fromJson(Map<dynamic, dynamic> json) {
    return CreateIngredientResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data']
    );
  }
}
