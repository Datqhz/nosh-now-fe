import 'package:management_app/data/models/error_response.dart';

class GetRestaurantStatisticResponse extends ErrorResponse {
  RestaurantStatisticData? data;

  GetRestaurantStatisticResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory GetRestaurantStatisticResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetRestaurantStatisticResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null
          ? RestaurantStatisticData.fromJson(json['data'])
          : null,
    );
  }
}

class RestaurantStatisticData {
  int totalSuccessOrder;
  int totalFailedOrder;
  int totalRejectedOrder;
  double totalRevenue;
  List<TopFoodData> topFoods;

  RestaurantStatisticData(
      {required this.totalSuccessOrder,
      required this.totalFailedOrder,
      required this.totalRejectedOrder,
      required this.totalRevenue,
      required this.topFoods});

  factory RestaurantStatisticData.fromJson(Map<dynamic, dynamic> json) {
    return RestaurantStatisticData(
        totalSuccessOrder: json['totalSuccessOrder'],
        totalFailedOrder: json['totalFailedOrder'],
        totalRejectedOrder: json['totalRejectedOrder'],
        totalRevenue: json['totalRevenue'] / 1.0,
        topFoods: (json['topFoods'] as List)
            .map((e) => TopFoodData.fromJson(e))
            .toList());
  }
}

class TopFoodData {
  String foodName;
  double totalRevenue;

  TopFoodData({required this.foodName, required this.totalRevenue});

  factory TopFoodData.fromJson(Map<dynamic, dynamic> json) {
    return TopFoodData(
        foodName: json['foodName'], totalRevenue: json['totalRevenue'] / 1.0);
  }
}
