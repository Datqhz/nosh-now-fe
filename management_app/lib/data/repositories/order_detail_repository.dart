import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/requests/update_status_orderdetail_request.dart';
import 'package:management_app/data/responses/update_order_detail_status_response.dart';

class OrderDetailRepository {

  Future<bool> updateOrderDetail(UpdateStatusOrderdetailRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response =
          await put(Uri.parse("${GlobalVariable.url}/order/api/v1/OrderDetail/PrepareStatus"),
              headers: headers,
              body: jsonEncode(request.toJson(),),);
      
      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateOrderDetailStatusResponse.fromJson(data);
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
