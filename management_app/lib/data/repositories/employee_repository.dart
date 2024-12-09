import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/requests/get_employees.dart';
import 'package:management_app/data/requests/update_employee_request.dart';
import 'package:management_app/data/responses/get_employees_data.dart';
import 'package:management_app/data/responses/profile_response.dart';
import 'package:management_app/data/responses/update_profile_response.dart';

class EmployeeRepository {
  Future<List<GetEmployeesData>?> getEmployees(
      GetEmployeesRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await post(
          Uri.parse("${GlobalVariable.url}/core/api/v1/Employee/Employees"),
          headers: headers,
          body: jsonEncode(request.toJson()));

      int statusCode = response.statusCode;

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetEmployeesResponse.fromJson(data);
      if (statusCode == 200) {
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      print(e.toString());
      showSnackBar(context, 'Some error has occurred');
    }

    return null;
  }

  Future<bool> getEmployeeProfile(String employeeId, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse(
              "${GlobalVariable.url}/core/api/v1/Employee/$employeeId/Profile"),
          headers: headers);

      int statusCode = response.statusCode;

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = ProfileResponse.fromJson(data);
      if (statusCode == 200) {
        GlobalVariable.profile = responseData.data;
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      print(e.toString());
      showSnackBar(context, 'Some error has occured');
    }

    return false;
  }

  Future<bool> getProfile(BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse(
              "${GlobalVariable.url}/core/api/v1/Employee/Profile"),
          headers: headers);

      int statusCode = response.statusCode;

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = ProfileResponse.fromJson(data);
      if (statusCode == 200) {
        GlobalVariable.profile = responseData.data;
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      print(e.toString());
      showSnackBar(context, 'Some error has occured');
    }

    return false;
  }


  Future<bool> updateProfile(
      UpdateEmployeeRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await put(
          Uri.parse(
              "${GlobalVariable.url}/core/api/v1/Employee"),
          headers: headers,
          body: jsonEncode(request.toJson()));
      int statusCode = response.statusCode;

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateProfileResponse.fromJson(data);
      if (statusCode == 200) {
        showSnackBar(context, "Update successful!");
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      print(e.toString());
      showSnackBar(context, 'Some error has occurred');
    }

    return false;
  }

  Future<bool> deleteEmployee(String id, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await delete(
          Uri.parse("${GlobalVariable.url}/core/api/v1/Employee/$id"),
          headers: headers);
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
