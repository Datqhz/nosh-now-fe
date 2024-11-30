import 'package:nosh_now_application/data/responses/error_response.dart';

class GetFoodDetailResponse extends ErrorResponse {
  FoodDetailData? data;
  GetFoodDetailResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory GetFoodDetailResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetFoodDetailResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? FoodDetailData.fromJson(json['data']) : null
    );
  }
}

class FoodDetailData{
  int foodId;
  String foodName;
  String foodDescription;
  String foodImage;
  double foodPrice;
  
  FoodDetailData({
    required this.foodId, 
    required this.foodName,
    required this.foodDescription,
    required this.foodImage,
    required this.foodPrice
  });

  factory FoodDetailData.fromJson(Map<dynamic, dynamic> json) {
    return FoodDetailData(
      foodId: json['foodId'],
      foodName: json['foodName'],
      foodDescription: json['foodDescription'],
      foodImage: json['foodImage'],
      foodPrice: json['foodPrice'] / 1.0
    );
  }
}
