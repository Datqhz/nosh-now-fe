import 'package:nosh_now_application/data/responses/error_response.dart';

class GetFoodByIdResponse extends ErrorResponse {

  GetFoodByIdData? data;

  GetFoodByIdResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory GetFoodByIdResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetFoodByIdResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? GetFoodByIdData.fromJson(json['data']) : null,
    );
  }
}


// TODO: change foodDescription to required //
class GetFoodByIdData{
  int foodId;
  String foodName;
  String foodImage;
  double foodPrice;
  String? foodDescription;
  
  GetFoodByIdData({
    required this.foodId, 
    required this.foodName,
    required this.foodImage,
    required this.foodPrice,
    this.foodDescription
  });

  factory GetFoodByIdData.fromJson(Map<dynamic, dynamic> json) {
    return GetFoodByIdData(
      foodId: json['foodId'],
      foodName: json['foodName'],
      foodImage: json['foodImage'],
      foodPrice: json['foodPrice'],
      foodDescription: json['foodDescription'] ?? null
    );
  }
}