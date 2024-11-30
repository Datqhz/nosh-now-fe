import 'package:nosh_now_application/data/models/account.dart';
import 'package:nosh_now_application/data/models/category.dart';

class Merchant {
  int merchantId;
  String displayName;
  String avatar;
  String phone;
  String email;
  String openingTime;
  String closingTime;
  String coordinator;
  bool status;
  Account? account;
  FoodCategory? category;
  Merchant(
      {required this.merchantId,
      required this.displayName,
      required this.email,
      required this.phone,
      required this.avatar,
      required this.openingTime,
      required this.closingTime,
      required this.coordinator,
      required this.status,
      this.category,
      this.account});
  factory Merchant.fromJson(Map<dynamic, dynamic> json) {
    return Merchant(
      merchantId: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
      coordinator: json['coordinator'],
      status: json['status'],
      account:
          json['account'] != null ? Account.fromJson(json['account']) : null,
          category:
          json['category'] != null ? FoodCategory.fromJson(json['category']) : null,
    );
  }
   Map<String, dynamic> toJson() => {
        'id': merchantId,
        "displayName": displayName,
        'email': email,
        'phone': phone,
        'avatar': avatar,
        'openingTime': openingTime,
        'closingTime': closingTime,
        'coordinator': coordinator,
        'account': account ?? account!.toJson(),
        'category': category ?? category!.toJson()
      };
}
