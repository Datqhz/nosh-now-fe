import 'package:nosh_now_application/data/responses/error_response.dart';

class GetOrdersResponse extends ErrorResponse{
  List<GetOrdersData>? data;
  GetOrdersResponse({required super.status, required super.statusText, required super.errorMessage, required super.errorMessageCode, this.data});
factory GetOrdersResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetOrdersResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? (json['data'] as List).map((e) => GetOrdersData.fromJson(e)).toList(): null,
    );
  }
}

class GetOrdersData {
  int orderId;
  DateTime orderDate;
  double totalPay;
  int orderStatus;
  String restaurantName;

  GetOrdersData({
    required this.orderId, 
    required this.orderDate,
    required this.totalPay,
    required this.orderStatus,
    required this.restaurantName,
  });

  factory GetOrdersData.fromJson(Map<dynamic, dynamic> json) {
    return GetOrdersData(
      orderId: json['orderId'],
      orderDate: DateTime.parse(json['orderDate']),
      totalPay: json['totalPay'] / 1.0,
      restaurantName: json['restaurantName'],
      orderStatus: json['orderStatus']
    );
  }
}