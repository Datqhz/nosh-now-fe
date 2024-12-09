import 'package:management_app/data/models/order_detail_status.dart';

class OrderDetailData {
  int orderDetailId;
  String foodName;
  String foodImage;
  double foodPrice;
  int amount;
  OrderDetailStatus status;

  OrderDetailData(
      {required this.orderDetailId,
      required this.foodName,
      required this.foodImage,
      required this.foodPrice,
      required this.amount,
      required this.status});

  factory OrderDetailData.fromJson(Map<dynamic, dynamic> json) {
    return OrderDetailData(
        orderDetailId: json['orderDetailId'],
        foodName: json['foodName'],
        foodImage: json['foodImage'],
        foodPrice: json['foodPrice'] / 1.0,
        amount: json['amount'],
        status: OrderDetailStatus.values[json['status']]);
  }
}
