import 'package:management_app/data/models/error_response.dart';

class GetRestaurantOrverviewResponse extends ErrorResponse {
  GetRestaurantOverviewData? data;

  GetRestaurantOrverviewResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory GetRestaurantOrverviewResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetRestaurantOrverviewResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null
          ? GetRestaurantOverviewData.fromJson(json['data'])
          : null,
    );
  }
}

class GetRestaurantOverviewData {
  int totalSuccessOrder;
  double totalRevenueInMonth;
  double totalRevenueInDay;

  GetRestaurantOverviewData(
      {required this.totalSuccessOrder,
      required this.totalRevenueInMonth,
      required this.totalRevenueInDay});

  factory GetRestaurantOverviewData.fromJson(Map<dynamic, dynamic> json) {
    return GetRestaurantOverviewData(
      totalSuccessOrder: json['totalSuccessOrder'],
      totalRevenueInMonth: json['totalRevenueInMonth'] / 1.0,
      totalRevenueInDay: json['totalRevenueInDay'] / 1.0,
    );
  }
}
