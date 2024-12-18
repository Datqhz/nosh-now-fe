import 'package:management_app/data/responses/error_response.dart';

class CreateCategoryResponse extends ErrorResponse {

  String? data;
  CreateCategoryResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory CreateCategoryResponse.fromJson(Map<dynamic, dynamic> json) {
    return CreateCategoryResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data']
    );
  }
}