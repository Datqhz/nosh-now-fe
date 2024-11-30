import 'package:nosh_now_application/data/responses/error_response.dart';

class GetOrderInitResponse extends ErrorResponse {

  GetOrderInitData? data;
  GetOrderInitResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory GetOrderInitResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetOrderInitResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? GetOrderInitData.fromJson(json['data']) : null,
    );
  }
}


class GetOrderInitData{
  int orderId;
  List<OrderDetailData> orderDetails;
  
  GetOrderInitData({
    required this.orderId, 
    required this.orderDetails
  });

  factory GetOrderInitData.fromJson(Map<dynamic, dynamic> json) {
    return GetOrderInitData(
      orderId: json['orderId'],
      orderDetails: json['orderDetails'] != null ? (json['orderDetails'] as List).map((e) => OrderDetailData.fromJson(e)).toList(): [],
    );
  }
}

class OrderDetailData{
  int id;
  int foodId;
  int amount;

  OrderDetailData({
    required this.id, 
    required this.foodId,
    required this.amount
  });

  factory OrderDetailData.fromJson(Map<dynamic, dynamic> json) {
    return OrderDetailData(
      id: json['id'],
      foodId: json['foodId'],
      amount: json['amount']
    );
  }
}