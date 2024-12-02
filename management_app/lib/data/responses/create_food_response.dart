
import 'package:management_app/data/responses/error_response.dart';

class CreateFoodResponse extends ErrorResponse {

  int? data;
  CreateFoodResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory CreateFoodResponse.fromJson(Map<dynamic, dynamic> json) {
    return CreateFoodResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data']
    );
  }
}
