import 'package:nosh_now_application/data/responses/error_response.dart';

class GetOrderInitByIdResponse extends ErrorResponse {
  GetOrderInitByIdData? data;
  GetOrderInitByIdResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory GetOrderInitByIdResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetOrderInitByIdResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null
          ? GetOrderInitByIdData.fromJson(json['data'])
          : null,
    );
  }
}

class GetOrderInitByIdData {
  int orderId;
  String restaurantName;
  double substantial;
  String restaurantCoordinate;
  List<OrderDetailData> orderDetails;

  GetOrderInitByIdData(
      {required this.orderId,
      required this.restaurantName,
      required this.substantial,
      required this.orderDetails,
      required this.restaurantCoordinate});

  factory GetOrderInitByIdData.fromJson(Map<dynamic, dynamic> json) {
    return GetOrderInitByIdData(
      orderId: json['orderId'],
      restaurantName: json['restaurantName'],
      substantial: json['substantial'],
      restaurantCoordinate: json['restaurantCoordinate'],
      orderDetails: json['orderDetails'] != null
          ? (json['orderDetails'] as List)
              .map((e) => OrderDetailData.fromJson(e))
              .toList()
          : [],
    );
  }
}

class OrderDetailData {
  int orderDetailId;
  String foodName;
  String foodImage;
  double foodPrice;
  int amount;

  OrderDetailData(
      {required this.orderDetailId,
      required this.foodName,
      required this.foodImage,
      required this.foodPrice,
      required this.amount});

  factory OrderDetailData.fromJson(Map<dynamic, dynamic> json) {
    return OrderDetailData(
        orderDetailId: json['orderDetailId'],
        foodName: json['foodName'],
        foodImage: json['foodImage'],
        foodPrice: json['foodPrice'] / 1.0,
        amount: json['amount']);
  }
}
