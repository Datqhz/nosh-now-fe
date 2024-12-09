import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/requests/create_calendars_request.dart';
import 'package:management_app/data/requests/delete_calendar_request.dart';
import 'package:management_app/data/requests/get_calendars_request.dart';
import 'package:management_app/data/responses/get_Calendars_response.dart';
import 'package:management_app/data/responses/update_calendars_response.dart';

class CalendarRepository {
  Future<bool> createCalendars(
      CreateCalendarsRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await post(
          Uri.parse("${GlobalVariable.url}/core/api/v1/Calendar/AddCalendars"),
          headers: headers,
          body: jsonEncode(request.toJson()));

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetCalendarsResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occured");
      print(e.toString());
    }

    return false;
  }

  Future<bool> deleteCalendars(
      DeleteCalendarsRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await put(
          Uri.parse(
              "${GlobalVariable.url}/core/api/v1/Calendar/DeleteCalendars"),
          headers: headers,
          body: jsonEncode(request.toJson()));

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateCalendarsResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }

    return false;
  }

  Future<List<GetCalendarsData>> getCalendars(
      GetCalendarsRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse(
              "${GlobalVariable.url}/core/api/v1/Calendar/Calendars?fromDate=${request.fromDate}&toDate=${request.toDate}"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetCalendarsResponse.fromJson(data);
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
