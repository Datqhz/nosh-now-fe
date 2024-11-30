import 'package:nosh_now_application/data/models/role.dart';

class Account {
  int accountId;
  String email;
  DateTime createdDate;
  Role? role;
  Account({required this.accountId, required this.email, required this.createdDate, this.role});
  factory Account.fromJson(Map<dynamic, dynamic> json) {
    return Account(
        accountId: json['id'],
        email: json['email'],
        createdDate: DateTime.parse(json['createdDate']),
        role: json['role'] != null ? Role.fromJson(json['role']) : null);
  }
  Map<String, dynamic> toJson() => {
        'id': accountId,
        'email': email,
        'role': role ?? role!.toJson(),
      };
}
