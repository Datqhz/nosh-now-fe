import 'package:nosh_now_application/data/responses/error_response.dart';

class UpdateOrderDetailResponse extends ErrorResponse {

  UpdateOrderDetailResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode
  });

  factory UpdateOrderDetailResponse.fromJson(Map<dynamic, dynamic> json) {
    return UpdateOrderDetailResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}
