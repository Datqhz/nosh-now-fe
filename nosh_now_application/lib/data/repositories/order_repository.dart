import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nosh_now_application/core/constants/global_variable.dart';
import 'package:nosh_now_application/core/utils/snack_bar.dart';
import 'package:nosh_now_application/data/requests/checkout_order_request.dart';
import 'package:nosh_now_application/data/requests/get_orders_request.dart';
import 'package:nosh_now_application/data/responses/checkout_order_response.dart';
import 'package:nosh_now_application/data/responses/get_order_by_id_response.dart';
import 'package:nosh_now_application/data/responses/get_order_init_byid_response.dart';
import 'package:nosh_now_application/data/responses/get_order_init_response.dart';
import 'package:nosh_now_application/data/responses/get_orders_response.dart';

//all role
class OrderRepository {
  Future<GetOrderInitByIdData?> getOrderInitById(
      int orderId, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse(
              "${GlobalVariable.url}/order/api/v1/Order/PrepareOrder/$orderId"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetOrderInitByIdResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
      return null;
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
      return null;
    }
  }

  Future<GetOrderByIdData?> getOrderById(
      int orderId, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Order/$orderId"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetOrderByIdResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
      return null;
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
      return null;
    }
  }

  Future<GetOrderInitData?> getOrderInit(
      String restaurantId, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse(
              "${GlobalVariable.url}/order/api/v1/Order/GetOrderInit/$restaurantId"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetOrderInitResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
      return null;
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
      return null;
    }
  }

  Future<bool> checkoutOrder(
      CheckoutOrderRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await post(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Order/Checkout"),
          headers: headers,
          body: jsonEncode(request.toJson()));

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = CheckoutOrderResponse.fromJson(data);
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

  Future<bool> cancelOrder(int orderId, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Order/Cancel/$orderId"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = CheckoutOrderResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        showSnackBar(context, "Cancel order successful!");
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

  Future<List<GetOrdersData>?> getOrders(
      GetOrdersRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse(
              "${GlobalVariable.url}/order/api/v1/Order/GetByStatus?orderStatus=${request.orderStatus}&sortDirection=${request.sortDirection}"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetOrdersResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
      return null;
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
      return null;
    }
  }
}
