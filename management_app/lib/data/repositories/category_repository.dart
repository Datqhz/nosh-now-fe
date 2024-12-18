import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/requests/create_category_request.dart';
import 'package:management_app/data/requests/update_category_request.dart';
import 'package:management_app/data/responses/create_category_response.dart';
import 'package:management_app/data/responses/get_categories_response.dart';

class CategoryRepository {
  Future<String> createCategory(
      CreateCategoryRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await post(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Category"),
          headers: headers,
          body: jsonEncode(request.toJson()));

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = CreateCategoryResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        showSnackBar(context, "Create successful");
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }

    return '';
  }

  Future<bool> updateCategory(
      UpdateCategoryRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await put(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Category"),
          headers: headers,
          body: jsonEncode(request.toJson()));

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = CreateCategoryResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        showSnackBar(context, "Update successful");
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }

    return false;
  }

  Future<bool> deleteCategory(int id, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await delete(
        Uri.parse("${GlobalVariable.url}/order/api/v1/Category/$id"),
        headers: headers,
      );

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetCategoriesResponse.fromJson(data);
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

  Future<List<GetCategoriesData>> getCategories(BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      Response response = await get(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Category/Categories"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetCategoriesResponse.fromJson(data);
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
}
