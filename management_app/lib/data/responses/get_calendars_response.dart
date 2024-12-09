import 'dart:ffi';

import 'package:management_app/data/responses/error_response.dart';

class GetCalendarsResponse extends ErrorResponse {
  List<GetCalendarsData>? data;
  GetCalendarsResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory GetCalendarsResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetCalendarsResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => GetCalendarsData.fromJson(e))
              .toList()
          : null,
    );
  }
}

class GetCalendarsData {
  int id;
  DateTime startTime;
  DateTime endTime;

  GetCalendarsData(
      {required this.id, required this.startTime, required this.endTime});

  factory GetCalendarsData.fromJson(Map<dynamic, dynamic> json) {
    return GetCalendarsData(
        id: json['id'],
        startTime: DateTime.parse(json['startTime']),
        endTime: DateTime.parse(json['endTime']));
  }
}
