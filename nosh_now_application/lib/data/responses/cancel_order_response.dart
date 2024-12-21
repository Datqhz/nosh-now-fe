import 'package:nosh_now_application/data/responses/error_response.dart';

class CancelOrderResponse extends ErrorResponse {

  CancelOrderResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
  });

  factory CancelOrderResponse.fromJson(Map<dynamic, dynamic> json) {
    return CancelOrderResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}
