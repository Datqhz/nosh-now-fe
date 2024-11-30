import 'package:nosh_now_application/data/models/food.dart';

class OrderDetail{
  int odId;
  int orderId;
  double price;
  int quantity;
  Food food;
  OrderDetail({
    required this.odId,
    required this.orderId,
    required this.price,
    required this.quantity,
    required this.food,
  });
  factory OrderDetail.fromJson(Map<dynamic, dynamic> json) {
    return OrderDetail(
        odId: json['id'],
        orderId: json['orderId'],
        price: json['price'] / 1.0,
        quantity: json['quantity'],
        food: Food.fromJson(json['food']));
  }

}
