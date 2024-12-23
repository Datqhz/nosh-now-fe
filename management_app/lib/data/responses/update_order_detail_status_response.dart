import 'package:management_app/data/responses/error_response.dart';

class UpdateOrderDetailStatusResponse extends ErrorResponse {
  UpdateOrderDetailStatusResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode});

  factory UpdateOrderDetailStatusResponse.fromJson(Map<dynamic, dynamic> json) {
    return UpdateOrderDetailStatusResponse(
        status: json['status'],
        statusText: json['statusText'],
        errorMessage: json['errorMessage'],
        errorMessageCode: json['errorMessageCode']);
  }
}
