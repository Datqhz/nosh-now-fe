import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nosh_now_application/core/constants/global_variable.dart';
import 'package:nosh_now_application/core/utils/snack_bar.dart';
import 'package:nosh_now_application/data/providers/hub/hub_provider.dart';
import 'package:nosh_now_application/data/requests/update_profile_request.dart';
import 'package:nosh_now_application/data/responses/profile_response.dart';
import 'package:nosh_now_application/data/responses/update_profile_response.dart';
import 'package:provider/provider.dart';

class CustomerRepository {

  Future<bool> getProfile(BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse("${GlobalVariable.url}/core/api/v1/Customer/Profile"),
          headers: headers);

      int statusCode = response.statusCode;

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = ProfileResponse.fromJson(data);
      if (statusCode == 200) {
        GlobalVariable.profile = responseData.data;
        await Provider.of<HubProvider>(context, listen: false).connectToNotifyHub();
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
  Future<bool> updateProfile(UpdateProfileRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response =
          await put(Uri.parse("${GlobalVariable.url}/core/api/v1/Customer/UpdateProfile"),
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
}
