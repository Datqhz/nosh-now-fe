import 'package:management_app/data/models/error_response.dart';

class GetTransferTransactionsResponse extends ErrorResponse {
  List<GetTransferTransactionsData>? data;

  GetTransferTransactionsResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory GetTransferTransactionsResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetTransferTransactionsResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null
          ? (json['data'] as List).map((e) => GetTransferTransactionsData.fromJson(e)).toList(): null,
    );
  }
}

class GetTransferTransactionsData {
  String restaurantId;
  String restaurantName;
  String avatar;
  double amount;
  int totalTransactions; 

  GetTransferTransactionsData(
      {required this.restaurantId,
      required this.restaurantName,
      required this.avatar,
      required this.amount,
      required this.totalTransactions});

  factory GetTransferTransactionsData.fromJson(Map<dynamic, dynamic> json) {
    return GetTransferTransactionsData(
        restaurantId: json['restaurantId'],
        restaurantName: json['restaurantName'],
        avatar: json['avatar'],
        amount: json['amount'] / 1.0,
        totalTransactions: json['totalTransactions']
    );
  }
}

