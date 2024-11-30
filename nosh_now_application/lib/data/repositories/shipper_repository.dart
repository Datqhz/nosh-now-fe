import 'dart:convert';

import 'package:http/http.dart';
import 'package:nosh_now_application/core/constants/global_variable.dart';
import 'package:nosh_now_application/data/models/shipper.dart';

class ShipperRepository {

  Future<List<Shipper>> getAllShipper() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse(
              "${GlobalVariable.url}/api/shipper"),
          headers: headers);
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        return [];
      }
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Shipper.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to get data');
    }
  }

  Future<bool> create(Shipper shipper, int accountId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      Response response =
          await post(Uri.parse("${GlobalVariable.url}/api/shipper"),
              headers: headers,
              body: jsonEncode(<String, dynamic>{
                "displayName": shipper.displayName,
                "avatar": shipper.avatar,
                "email": shipper.email,
                "phone": shipper.phone,
                "vehicleName": shipper.vehicleName,
                "momoPayment": shipper.momoPayment,
                "coordinator": shipper.coordinator,
                "accountId": accountId,
                "vehicleTypeId": shipper.vehicleType!.typeId
              }));
      int statusCode = response.statusCode;
      if (statusCode != 201) {
        return false;
      }
      return true;
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to register');
    }
  }
  Future<Shipper?> update(Shipper shipper) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response =
          await put(Uri.parse("${GlobalVariable.url}/api/shipper"),
              headers: headers,
              body: jsonEncode(<String, dynamic>{
                "id": shipper.shipperId,
                "displayName": shipper.displayName,
                "avatar": shipper.avatar,
                "email": shipper.email,
                "phone": shipper.phone,
                "vehicleName": shipper.vehicleName,
                "momoPayment": shipper.momoPayment,
                "coordinator": '0-0',
                "vehicleTypeId": shipper.vehicleType!.typeId
              }));
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        return null;
      }
      Map<String, dynamic> data = json.decode(response.body);
      return Shipper.fromJson(data);
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to register');
    }
  }
}
