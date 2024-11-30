import 'package:nosh_now_application/data/responses/error_response.dart';

class DeleteOrderDetailResponse extends ErrorResponse {

  DeleteOrderDetailResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode
  });

  factory DeleteOrderDetailResponse.fromJson(Map<dynamic, dynamic> json) {
    return DeleteOrderDetailResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode']
    );
  }
}
