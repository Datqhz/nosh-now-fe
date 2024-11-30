import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nosh_now_application/core/constants/global_variable.dart';
import 'package:nosh_now_application/core/utils/snack_bar.dart';
import 'package:nosh_now_application/data/requests/create_orderdetail_request.dart';
import 'package:nosh_now_application/data/requests/update_orderdetail_request.dart';
import 'package:nosh_now_application/data/responses/create_orderdetail_response.dart';
import 'package:nosh_now_application/data/responses/update_orderdetail_response.dart';

class OrderDetailRepository {


  Future<int?> createOrderDetail(CreateOrderDetailRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response =
          await post(Uri.parse("${GlobalVariable.url}/order/api/v1/OrderDetail"),
              headers: headers,
              body: jsonEncode(request.toJson(),),);
      
      Map<String, dynamic> data = json.decode(response.body);
      var responseData = CreateOrderDetailResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 201) {
        return responseData.data;
      }

      showSnackBar(context, responseData.statusText!);
      return null;
    } catch (e) {

      showSnackBar(context, "An error has occurred");
      print(e.toString());
      return null;
    }
  }

  Future<bool> updateOrderDetail(UpdateOrderDetailRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response =
          await put(Uri.parse("${GlobalVariable.url}/order/api/v1/OrderDetail"),
              headers: headers,
              body: jsonEncode(request.toJson(),),);
      
      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateOrderDetailResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return true;
      }

      showSnackBar(context, responseData.statusText!);
      return false;
    } catch (e) {

      showSnackBar(context, "An error has occurred");
      print(e.toString());
      return false;
    }
  }


  Future<bool> deleteOrderDetail(int id, BuildContext context) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${GlobalVariable.jwt}"
      };
      Response response = await delete(
          Uri.parse("${GlobalVariable.url}/order/api/v1/OrderDetail/$id"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateOrderDetailResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return true;
      }

      showSnackBar(context, responseData.statusText!);
      return false;
    } catch (e) {

      showSnackBar(context, "An error has occurred");
      print(e.toString());
      return false;
    }
  }
}
