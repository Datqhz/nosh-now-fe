import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/models/food_data.dart';
import 'package:management_app/data/requests/create_food_request.dart';
import 'package:management_app/data/requests/update_food_request.dart';
import 'package:management_app/data/responses/create_food_response.dart';
import 'package:management_app/data/responses/get_food_byid_response.dart';
import 'package:management_app/data/responses/get_foods_response.dart';
import 'package:management_app/data/responses/update_food_response.dart';

class FoodRepository {


  Future<List<FoodData>> getFoodByRestaurantId(String restaurantId, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Food/Foods/$restaurantId"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetFoodsResponse.fromJson(data);
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

  Future<int?> createFood(CreateFoodRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response =
          await post(Uri.parse("${GlobalVariable.url}/order/api/v1/Food"),
              headers: headers,
              body: jsonEncode(request.toJson()));
       Map<String, dynamic> data = json.decode(response.body);
      var responseData = CreateFoodResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        showSnackBar(context, "Create successful!");
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {

      showSnackBar(context, "An error has occurred");
      print(e.toString());

    }

    return null;
  }

  Future<bool> updateFood(UpdateFoodRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await put(Uri.parse("${GlobalVariable.url}/order/api/v1/Food"),
          headers: headers,
          body: jsonEncode(request.toJson()));


      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateFoodResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        showSnackBar(context, "Update successful!");
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {

      showSnackBar(context, "An error has occured");
      print(e.toString());
    }

    return false;
  }

  //merchant
  Future<bool> deleteFood(int id, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await delete(
        Uri.parse("${GlobalVariable.url}/order/api/v1/food/$id"),
        headers: headers,
      );
      
      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateFoodResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        showSnackBar(context, "Delete successful");
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {

      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }

    return false;
  }
}
