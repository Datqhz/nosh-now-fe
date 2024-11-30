import 'package:nosh_now_application/data/models/delivery_info.dart';
import 'package:nosh_now_application/data/responses/error_response.dart';
import 'package:nosh_now_application/data/responses/get_order_init_byid_response.dart';

class GetOrderByIdResponse extends ErrorResponse {

  GetOrderByIdData? data;
  GetOrderByIdResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory GetOrderByIdResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetOrderByIdResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? GetOrderByIdData.fromJson(json['data']) : null,
    );
  }
}


class GetOrderByIdData{
  int orderId;
  DateTime orderDate;
  double substantial;
  double shippingFee;
  double total;
  int orderStatus;
  String restaurantName;
  DeliveryInfo deliveryInfo;
  String? shipperName;
  String? shipperImage;
  String restaurantCoordinate;
  String customerName;
  List<OrderDetailData> orderDetails;
  
  GetOrderByIdData({
    required this.orderId, 
    required this.orderDate,
    required this.shippingFee,
    required this.total,
    required this.deliveryInfo,
    required this.orderStatus,
    this.shipperName,
    this.shipperImage,
    required this.restaurantName,
    required this.substantial,
    required this.orderDetails,
    required this.restaurantCoordinate,
    required this.customerName
  });

  factory GetOrderByIdData.fromJson(Map<dynamic, dynamic> json) {
    return GetOrderByIdData(
      orderId: json['orderId'],
      orderDate: DateTime.parse(json['orderDate']),
      shippingFee: json['shippingFee'] / 1.0,
      total: json['total'] / 1.0,
      deliveryInfo: DeliveryInfo.fromJson(json['deliveryInfo']),
      shipperName: json['shipperName'],
      orderStatus: json['orderStatus'],
      shipperImage: json['shipperImage'],
      restaurantName: json['restaurantName'],
      customerName: json['customerName'],
      substantial: json['substantial'] / 1.0,
      restaurantCoordinate: json['restaurantCoordinate'],
      orderDetails: json['orderDetails'] != null ? (json['orderDetails'] as List).map((e) => OrderDetailData.fromJson(e)).toList(): [],
    );
  }
}
