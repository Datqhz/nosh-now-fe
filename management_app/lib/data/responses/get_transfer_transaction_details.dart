import 'package:management_app/data/models/error_response.dart';

class GetTransferTransactionDetailsResponse extends ErrorResponse {
  GetTransferTransactionDetailsData? data;

  GetTransferTransactionDetailsResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory GetTransferTransactionDetailsResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetTransferTransactionDetailsResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? GetTransferTransactionDetailsData.fromJson(json['data']) : null,
    );
  }
}

class GetTransferTransactionDetailsData {
  String restaurantId;
  String restaurantName;
  String avatar;
  double amount;
  List<TransferTransactionData> transactions;

  GetTransferTransactionDetailsData(
      {required this.restaurantId,
      required this.restaurantName,
      required this.avatar,
      required this.amount,
      required this.transactions});

  factory GetTransferTransactionDetailsData.fromJson(Map<dynamic, dynamic> json) {
    return GetTransferTransactionDetailsData(
        restaurantId: json['restaurantId'],
        restaurantName: json['restaurantName'],
        avatar: json['avatar'],
        amount: json['amount'] / 1.0,
        transactions: (json['transactions'] as List).map((e) => TransferTransactionData.fromJson(e)).toList()
    );
  }
}

class TransferTransactionData {
  int transactionId;
  double amount;
  DateTime createdDate;
  bool isTransfer;
  String? proof; 

  TransferTransactionData(
      {required this.transactionId,
      required this.amount,
      required this.createdDate,
      required this.isTransfer,
      this.proof});

  factory TransferTransactionData.fromJson(Map<dynamic, dynamic> json) {
    return TransferTransactionData(
        transactionId: json['transactionId'],
        amount: json['amount'] /1.0,
        createdDate: DateTime.parse(json['createdDate']),
        isTransfer: json['isTransfer'] ,
        proof: json['proof']
    );
  }
}