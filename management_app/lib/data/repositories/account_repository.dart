import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/requests/change_password_request.dart';
import 'package:management_app/data/requests/login_request.dart';
import 'package:management_app/data/requests/register_request.dart';
import 'package:management_app/data/responses/change_password_response.dart';
import 'package:management_app/data/responses/login_response.dart';
import 'package:management_app/data/responses/register_response.dart';

class AccountRepository {
  // Sign in
  Future<bool> signIn(LoginRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      Response response = await post(
          Uri.parse("${GlobalVariable.url}/auth/api/v1/Authentication/Login"),
          headers: headers,
          body: jsonEncode(request.toJson()));

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = LoginResponse.fromJson(data);
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        GlobalVariable.jwt = responseData.data!.accessToken;
        GlobalVariable.scope = responseData.data!.scope;
        return true;
      }

      showSnackBar(context, responseData.statusText!);
      return false;
    } catch (e) {
      showSnackBar(context, "An error has occured");
      print(e.toString());
      return false;
    }
  }

  // Sign up
  Future<bool> signUp(RegisterRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      Response response = await post(
          Uri.parse(
              "${GlobalVariable.url}/auth/api/v1/Authentication/Register"),
          headers: headers,
          body: jsonEncode(request.toJson()));

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = RegisterResponse.fromJson(data);
      int statusCode = response.statusCode;
      if (statusCode == 201) {
        return true;
      }
      showSnackBar(context, responseData.statusText!);
      return false;
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e);
      return false;
    }
  }

  // Change password
  Future<bool> changePassword(
      ChangePasswordRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await put(
        Uri.parse(
            "${GlobalVariable.url}/auth/api/v1/Authentication/ChangePassword"),
        headers: headers,
        body: jsonEncode(
          request.toJson(),
        ),
      );
      
      int statusCode = response.statusCode;

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = ChangePasswordResponse.fromJson(data);
      if (statusCode == 200) {
        showSnackBar(context, "Change password successful");
        return true;
      }

      showSnackBar(context, responseData.statusText!);

    } catch (e) {
      print(e.toString());
      showSnackBar(context, 'Some error has occured');
    }
    
    return false;
  }
}
