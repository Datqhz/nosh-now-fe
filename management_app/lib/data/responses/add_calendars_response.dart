import 'package:management_app/data/responses/error_response.dart';
import 'package:management_app/data/responses/get_calendars_response.dart';

class AddCalendarsResponse extends ErrorResponse {
  
  List<GetCalendarsData>? data;

  AddCalendarsResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory AddCalendarsResponse.fromJson(Map<dynamic, dynamic> json) {
    return AddCalendarsResponse(
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
