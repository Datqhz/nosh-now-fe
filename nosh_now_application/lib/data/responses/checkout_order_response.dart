import 'package:nosh_now_application/data/responses/error_response.dart';

class CheckoutOrderResponse extends ErrorResponse {

  CheckoutOrderResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
  });

  factory CheckoutOrderResponse.fromJson(Map<dynamic, dynamic> json) {
    return CheckoutOrderResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}