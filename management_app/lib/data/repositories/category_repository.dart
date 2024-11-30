import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/responses/get_categories_response.dart';

class CategoryRepository {
  // Future<FoodCategory?> create(FoodCategory category) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     "Authorization": "Bearer ${GlobalVariable.jwt}"
  //   };
  //   try {
  //     Response response = await post(
  //         Uri.parse("${GlobalVariable.url}/api/category"),
  //         headers: headers,
  //         body: jsonEncode(<String, dynamic>{
  //           "categoryName": category.categoryName,
  //           "image": category.categoryImage
  //         }));
  //     int statusCode = response.statusCode;
  //     if (statusCode != 201) {
  //       return null;
  //     }
  //     Map<String, dynamic> data = json.decode(response.body);
  //     return FoodCategory.fromJson(data);
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception('Fail to save');
  //   }
  // }

  // Future<bool> update(FoodCategory category) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     "Authorization": "Bearer ${GlobalVariable.jwt}"
  //   };
  //   try {
  //     Response response =
  //         await put(Uri.parse("${GlobalVariable.url}/api/category"),
  //             headers: headers,
  //             body: jsonEncode(<String, dynamic>{
  //               "id": category.categoryId,
  //               "categoryName": category.categoryName,
  //               "image": category.categoryImage
  //             }));
  //     int statusCode = response.statusCode;
  //     print("body: ${response.body}");
  //     if (statusCode != 200) {
  //       return false;
  //     }
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception('Fail to save');
  //   }
  // }
  // Future<bool> deleteCategory(int id) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     "Authorization": "Bearer ${GlobalVariable.jwt}"
  //   };
  //   try {
  //     Response response =
  //         await delete(Uri.parse("${GlobalVariable.url}/api/category/$id"),
  //             headers: headers,
  //             );
  //     int statusCode = response.statusCode;
  //     print("body: ${response.body}");
  //     if (statusCode != 200) {
  //       return false;
  //     }
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception('Fail to delete');
  //   }
  // }

  Future<List<GetCategoriesData>> getCategories(BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      Response response = await get(
          Uri.parse("${GlobalVariable.url}/order/api/v1/Category/Categories"),
          headers: headers
      );

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
