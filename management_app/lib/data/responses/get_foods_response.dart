
import 'package:management_app/data/models/food_data.dart';
import 'package:management_app/data/responses/error_response.dart';

class GetFoodsResponse extends ErrorResponse {

  List<FoodData>? data;
  GetFoodsResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory GetFoodsResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetFoodsResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? (json['data'] as List).map((e) => FoodData.fromJson(e)).toList(): null,
    );
  }
}

