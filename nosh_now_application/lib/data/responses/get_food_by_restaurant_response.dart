import 'package:nosh_now_application/data/responses/error_response.dart';

class GetFoodsByRestaurantResponse extends ErrorResponse {
  List<GetFoodsData>? data;
  GetFoodsByRestaurantResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory GetFoodsByRestaurantResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetFoodsByRestaurantResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null
          ? (json['data'] as List).map((e) => GetFoodsData.fromJson(e)).toList()
          : null,
    );
  }
}

class GetFoodsData {
  int foodId;
  String foodName;
  String foodImage;
  double price;
  int available;

  GetFoodsData(
      {required this.foodId,
      required this.foodName,
      required this.foodImage,
      required this.price,
      required this.available});

  factory GetFoodsData.fromJson(Map<dynamic, dynamic> json) {
    return GetFoodsData(
        foodId: json['foodId'],
        foodName: json['foodName'],
        foodImage: json['foodImage'],
        price: json['price'],
        available: json['available']);
  }
}
