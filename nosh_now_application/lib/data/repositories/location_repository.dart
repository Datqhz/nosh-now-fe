import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:nosh_now_application/core/constants/global_variable.dart';
import 'package:nosh_now_application/core/utils/snack_bar.dart';
import 'package:nosh_now_application/data/requests/create_location_request.dart';
import 'package:nosh_now_application/data/requests/update_location_request.dart';
import 'package:nosh_now_application/data/responses/created_location_response.dart';
import 'package:nosh_now_application/data/responses/get_saved_locations_response.dart';

class LocationRepository {
  //eater
  Future<bool> createLocation(
      CreateLocationRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await post(
          Uri.parse("${GlobalVariable.url}/core/api/v1/Location/Saved"),
          headers: headers,
          body: jsonEncode(request.toJson()));

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = CreateLocationResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        showSnackBar(context, "Create successful");
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }

    return false;
  }

  //eater
  Future<bool> update(
      UpdateLocationRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await put(
          Uri.parse("${GlobalVariable.url}/core/api/v1/Location/Update"),
          headers: headers,
          body: jsonEncode(request.toJson()));

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = CreateLocationResponse.fromJson(data);
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

  // eater
  Future<bool> deleteSavedLocation(int id, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await delete(
        Uri.parse("${GlobalVariable.url}/core/api/v1/Location/Delete/$id"),
        headers: headers,
      );

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = CreateLocationResponse.fromJson(data);
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

  //eater
  Future<List<GetSavedLocationData>?> getSavedLocations(
      BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse(
              "${GlobalVariable.url}/core/api/v1/Location/SavedLocations"),
          headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetSavedLocationsResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data!;
      }

      showSnackBar(context, responseData.statusText!);
      return null;
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
      return null;
    }
  }
}
