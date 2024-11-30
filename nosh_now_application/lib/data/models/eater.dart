import 'package:nosh_now_application/data/models/account.dart';

class Eater {
  int eaterId;
  String displayName;
  String avatar;
  String phone;
  String email;
  Account? account;
  Eater(
      {required this.eaterId,
      required this.displayName,
      required this.email,
      required this.phone,
      required this.avatar,
      this.account});
  factory Eater.fromJson(Map<dynamic, dynamic> json) {
    return Eater(
      eaterId: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      account:
          json['account'] != null ? Account.fromJson(json['account']) : null,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': eaterId,
        "displayName": displayName,
        'email': email,
        'phone': phone,
        'avatar': avatar,
        'account': account ?? account!.toJson()
      };
}
