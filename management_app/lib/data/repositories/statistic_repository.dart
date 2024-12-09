import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/requests/get_restaurant_statistic_request.dart';
import 'package:management_app/data/responses/get_restaurant_overview_response.dart';
import 'package:management_app/data/responses/get_restaurant_statistic_response.dart';

class StatisticRepository {
  Future<RestaurantStatisticData?> getRestaurantStatistic(
      GetRestaurantStatisticRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url =
        "${GlobalVariable.url}/order/api/v1/Statistic/GetStatistics?fromDate=${request.fromDate}&toDate=${request.toDate}";
    try {
      Response response = await get(Uri.parse(url), headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetRestaurantStatisticResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }

    return null;
  }

  Future<GetRestaurantOverviewData?> getRestaurantOverview(
      DateTime date, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url =
        "${GlobalVariable.url}/order/api/v1/Statistic/Overview?date=$date";
    try {
      Response response = await get(Uri.parse(url), headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetRestaurantOrverviewResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }
    return null;
  }
}
