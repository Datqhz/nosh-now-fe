import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:nosh_now_application/core/constants/global_variable.dart';
import 'package:nosh_now_application/core/utils/snack_bar.dart';
import 'package:nosh_now_application/data/models/location.dart';
import 'package:nosh_now_application/data/responses/get_saved_locations_response.dart';

class LocationRepository {
  //eater
  Future<Location?> create(Location location, int eaterId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      Response response =
          await post(Uri.parse("${GlobalVariable.url}/api/location"),
              headers: headers,
              body: jsonEncode(<String, dynamic>{
                "locationName": location.locationName,
                "phone": location.phone,
                "coordinator": location.coordinator,
                "default": location.defaultLocation,
                "eaterId": eaterId
              }));
      int statusCode = response.statusCode;
      if (statusCode != 201) {
        return null;
      }
      return Location.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception('Fail to save location');
    }
  }

  //eater
  Future<Location> update(Location location) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response =
          await put(Uri.parse("${GlobalVariable.url}/api/location"),
              headers: headers,
              body: jsonEncode(<String, dynamic>{
                'id': location.locationId,
                "locationName": location.locationName,
                "phone": location.phone,
                "coordinator": location.coordinator,
                "default": location.defaultLocation,
              }));
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw Exception();
      }
      return Location.fromJson(json.decode(response.body));
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to save location');
    }
  }
  // eater
  Future<bool> deleteSavedLocation(int id) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await delete(
        Uri.parse("${GlobalVariable.url}/api/location/$id"),
        headers: headers,
      );
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to delete location');
    }
  }
  //eater
  Future<List<GetSavedLocationData>?> getSavedLocations(BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    try {
      Response response = await get(
          Uri.parse("${GlobalVariable.url}/core/api/v1/Location/SavedLocations"),
          headers: headers
      );
      

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
  //eater
  // Future<Location> getDefaultLocationByEater(int eaterId) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     "Authorization": "Bearer ${GlobalVariable.jwt}"
  //   };
  //   try {
  //     Response response = await get(
  //         Uri.parse("${GlobalVariable.url}/api/location/default/user/$eaterId"),
  //         headers: headers);
  //     int statusCode = response.statusCode;
  //     if (statusCode != 200) {
  //       throw Exception();
  //     }
  //     Map<String, dynamic> data = json.decode(response.body);
  //     return Location.fromJson(data);
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception('Fail to get data');
  //   }
  // }
}
