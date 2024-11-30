import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nosh_now_application/core/constants/global_variable.dart';
import 'package:nosh_now_application/core/utils/snack_bar.dart';
import 'package:nosh_now_application/data/requests/get_restaurant_by_category.dart';
import 'package:nosh_now_application/data/requests/get_restaurants_request.dart';
import 'package:nosh_now_application/data/responses/get_restaurants_response.dart';

class RestaurantRepository {


  Future<List<GetRestaurantsData>> getRestaurants(GetRestaurantsRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await post(
          Uri.parse(
              "${GlobalVariable.url}/core/api/v1/Restaurant/Restaurants"),
          headers: headers, 
          body: jsonEncode(request.toJson())
      );

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetRestaurantsResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
      return [];
    } catch (e) {

      showSnackBar(context, "An error has occured");
      print(e.toString());
      return [];
    }
  }

    Future<List<GetRestaurantsData>> getRestaurantsByCategory(GetRestaurantsByCategoryRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await post(
          Uri.parse(
              "${GlobalVariable.url}/order/api/v1/Restaurant/ByCategory"),
          headers: headers, 
          body: jsonEncode(request.toJson())
      );

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetRestaurantsResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
      return [];
    } catch (e) {

      showSnackBar(context, "An error has occured");
      print(e.toString());
      return [];
    }
  }


  // // manager
  // Future<List<Merchant>> getAllMerchant() async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     "Authorization": "Bearer ${GlobalVariable.jwt}"
  //   };
  //   try {
  //     Response response = await get(
  //         Uri.parse("${GlobalVariable.url}/api/merchant"),
  //         headers: headers);
  //     int statusCode = response.statusCode;
  //     if (statusCode != 200) {
  //       return [];
  //     }
  //     List<dynamic> data = json.decode(response.body);
  //     return data.map((e) => Merchant.fromJson(e)).toList();
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception('Fail to get data');
  //   }
  // }

  // // eater
  // Future<List<MerchantWithDistance>> FindByRegex(
  //     String regex, String coord) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     "Authorization": "Bearer ${GlobalVariable.jwt}"
  //   };
  //   try {
  //     Response response = await get(
  //         Uri.parse(
  //             "${GlobalVariable.url}/api/merchant/find?regex=$regex&coordinator=$coord"),
  //         headers: headers);
  //     int statusCode = response.statusCode;
  //     print(response.body);
  //     if (statusCode != 200) {
  //       return [];
  //     }
  //     List<dynamic> data = json.decode(response.body);
  //     return data.map((e) => MerchantWithDistance.fromJson(e)).toList();
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception('Fail to get data');
  //   }
  // }
}
