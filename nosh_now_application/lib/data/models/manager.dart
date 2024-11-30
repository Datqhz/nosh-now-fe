import 'package:nosh_now_application/data/models/account.dart';

class Manager {
  int managerId;
  String displayName;
  String avatar;
  String phone;
  String email;
  Account? account;
  Manager(
      {required this.managerId,
      required this.displayName,
      required this.email,
      required this.phone,
      required this.avatar,
      this.account});
  factory Manager.fromJson(Map<dynamic, dynamic> json) {
    return Manager(
      managerId: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      account:
          json['account'] != null ? Account.fromJson(json['account']) : null,
    );
  }
   Map<String, dynamic> toJson() => {
        'id': managerId,
        "displayName": displayName,
        'email': email,
        'phone': phone,
        'avatar': avatar,
        'account': account ?? account!.toJson()
      };
}
