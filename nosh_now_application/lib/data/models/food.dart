import 'package:nosh_now_application/data/models/merchant.dart';

class Food {
  int foodId;
  String foodName;
  String foodImage;
  String foodDescribe;
  double price;
  int status;
  Merchant? merchant;
  Food(
      {required this.foodId,
      required this.foodName,
      required this.foodImage,
      required this.foodDescribe,
      required this.price,
      required this.status,
      this.merchant});
  factory Food.fromJson(Map<dynamic, dynamic> json) {
    return Food(
      foodId: json['id'],
      foodName: json['foodName'],
      foodImage: json['foodImage'],
      foodDescribe: json['foodDescribe'],
      price: json['price'] / 1.0,
      status: json['status'],
      merchant:
          json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null,
    );
  }
}
