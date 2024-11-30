import 'package:nosh_now_application/data/responses/error_response.dart';

class CreateOrderDetailResponse extends ErrorResponse {

  int? data;
  CreateOrderDetailResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory CreateOrderDetailResponse.fromJson(Map<dynamic, dynamic> json) {
    return CreateOrderDetailResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data : json['data']
    );
  }
}
