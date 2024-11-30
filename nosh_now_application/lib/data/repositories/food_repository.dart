import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nosh_now_application/core/constants/global_variable.dart';
import 'package:nosh_now_application/core/utils/snack_bar.dart';
import 'package:nosh_now_application/data/models/food.dart';
import 'package:nosh_now_application/data/responses/get_food_by_restaurant_response.dart';
import 'package:nosh_now_application/data/responses/get_food_byid_response.dart';

class FoodRepository {


  Future<List<GetFoodsData>> getFoodByRestaurantId(String restaurantId, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Food/Foods/$restaurantId"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetFoodsByRestaurantResponse.fromJson(data);
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

  Future<GetFoodByIdData?> getFoodById(int foodId, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Food/$foodId"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetFoodByIdResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
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

  // merchant
  Future<Food?> create(Food food, int merchantId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response =
          await post(Uri.parse("${GlobalVariable.url}/api/food"),
              headers: headers,
              body: jsonEncode(<String, dynamic>{
                "foodName": food.foodName,
                "foodImage": food.foodImage,
                "foodDescribe": food.foodDescribe,
                "price": food.price,
                "status": food.status,
                "merchantId": merchantId
              }));
      int statusCode = response.statusCode;
      if (statusCode != 201) {
        print(response.body);
        return null;
      }
      return Food.fromJson(json.decode(response.body));
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to save food');
    }
  }

  // merchant
  Future<Food> update(Food food, int merchantId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await put(Uri.parse("${GlobalVariable.url}/api/food"),
          headers: headers,
          body: jsonEncode(<String, dynamic>{
            "id": food.foodId,
            "foodName": food.foodName,
            "foodImage": food.foodImage,
            "foodDescribe": food.foodDescribe,
            "price": food.price,
            "status": food.status,
          }));
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        print(response.body);
        throw Exception();
      }
      return Food.fromJson(json.decode(response.body));
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to save food');
    }
  }

  //merchant
  Future<bool> deleteFood(int id) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await delete(
        Uri.parse("${GlobalVariable.url}/api/food/$id"),
        headers: headers,
      );
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        print(response.body);
        return false;
      }
      return true;
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to delete food');
    }
  }
}
