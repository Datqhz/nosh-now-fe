import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/requests/create_ingredient_request.dart';
import 'package:management_app/data/requests/update_ingredient_request.dart';
import 'package:management_app/data/responses/create_ingredient_response.dart';
import 'package:management_app/data/responses/get_ingredients_response.dart';
import 'package:management_app/data/responses/update_food_response.dart';
import 'package:management_app/data/responses/update_ingredient_response.dart';

class IngredientRepository {
  Future<List<GetIngredientsData>> getIngredients(BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse(
              "${GlobalVariable.url}/order/api/v1/Ingredient/Ingredients"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetIngredientsResponse.fromJson(data);
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
      return [];
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
      return [];
    }
  }

  Future<int?> createIngredient(
      CreateIngredientRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      var requestMap = request.toJson();
      Response response = await post(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Ingredient"),
          headers: headers,
          body: jsonEncode(requestMap));
      Map<String, dynamic> data = json.decode(response.body);
      var responseData = CreateIngredientResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        showSnackBar(context, "Create successful!");
        return responseData.data!;
      }
      print(responseData.errorMessageCode);
      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }

    return null;
  }

  Future<bool> updateIngredient(
      UpdateIngredientRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await put(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Ingredient"),
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
  Future<bool> deleteIngredient(int id, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await delete(
        Uri.parse("${GlobalVariable.url}/order/api/v1/Ingredient/$id"),
        headers: headers,
      );
      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateIngredientResponse.fromJson(data);
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
