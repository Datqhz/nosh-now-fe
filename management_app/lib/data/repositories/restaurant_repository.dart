import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/providers/hub/hub_provider.dart';
import 'package:management_app/data/requests/update_restaurant_profile_request.dart';
import 'package:management_app/data/responses/profile_response.dart';
import 'package:management_app/data/responses/update_profile_response.dart';
import 'package:provider/provider.dart';

class RestaurantRepository {
  Future<bool> getProfile(BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse("${GlobalVariable.url}/core/api/v1/Restaurant/Profile"),
          headers: headers);

      int statusCode = response.statusCode;

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = ProfileResponse.fromJson(data);
      if (statusCode == 200) {
        GlobalVariable.profile = responseData.data;
        await Provider.of<HubProvider>(context, listen: false)
            .connectToNotifyHub();
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      print(e.toString());
      showSnackBar(context, 'Some error has occured');
    }

    return false;
  }

  //eater
  Future<bool> updateProfile(
      UpdateRestaurantProfileRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await put(
          Uri.parse(
              "${GlobalVariable.url}/core/api/v1/Restaurant/UpdateProfile"),
          headers: headers,
          body: jsonEncode(request.toJson()));
      int statusCode = response.statusCode;

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateProfileResponse.fromJson(data);
      if (statusCode == 200) {
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      print(e.toString());
      showSnackBar(context, 'Some error has occurred');
    }

    return false;
  }

  Future<bool> updateWorkingStatus(
      bool status, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await put(
          Uri.parse(
              "${GlobalVariable.url}/core/api/v1/Restaurant/WorkingStatus"),
          headers: headers,
          body: jsonEncode(<String, dynamic> {
            'status': status
          }));
      int statusCode = response.statusCode;

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateProfileResponse.fromJson(data);
      if (statusCode == 200) {
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      print(e.toString());
      showSnackBar(context, 'Some error has occurred');
    }

    return false;
  }
}
