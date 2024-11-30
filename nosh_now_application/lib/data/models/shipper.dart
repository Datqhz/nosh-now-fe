import 'package:nosh_now_application/data/models/account.dart';
import 'package:nosh_now_application/data/models/vehicle_type.dart';

class Shipper {
  int shipperId;
  String displayName;
  String avatar;
  String phone;
  String email;
  String vehicleName;
  String momoPayment;
  String coordinator;
  bool status;
  Account? account;
  VehicleType? vehicleType;
  Shipper(
      {required this.shipperId,
      required this.displayName,
      required this.email,
      required this.phone,
      required this.avatar,
      required this.vehicleName,
      required this.momoPayment,
      required this.coordinator,
      required this.status,
      this.account,
      this.vehicleType});
  factory Shipper.fromJson(Map<dynamic, dynamic> json) {
    return Shipper(
      shipperId: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      vehicleName: json['vehicleName'],
      momoPayment: json['momoPayment'],
      coordinator: json['coordinator'],
      status: json['status'],
      account:
          json['account'] != null ? Account.fromJson(json['account']) : null,
      vehicleType: json['vehicleType'] != null
          ? VehicleType.fromJson(json['vehicleType'])
          : null,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': shipperId,
        "displayName": displayName,
        'email': email,
        'phone': phone,
        'avatar': avatar,
        'vehicleName': vehicleName,
        'momoPayment': momoPayment,
        'coordinator': coordinator,
        'account': account ?? account!.toJson(),
        'vehicleType': vehicleType ?? vehicleType!.toJson()
      };
}
