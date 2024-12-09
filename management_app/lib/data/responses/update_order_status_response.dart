
import 'package:management_app/data/responses/error_response.dart';

class UpdateOrderStatusResponse extends ErrorResponse {

  UpdateOrderStatusResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode
  });

  factory UpdateOrderStatusResponse.fromJson(Map<dynamic, dynamic> json) {
    return UpdateOrderStatusResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}
