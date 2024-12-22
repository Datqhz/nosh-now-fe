import 'package:management_app/data/models/error_response.dart';

class GetAdminOverviewResponse extends ErrorResponse {
  GetAdminOverviewData? data;

  GetAdminOverviewResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory GetAdminOverviewResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetAdminOverviewResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null
          ? GetAdminOverviewData.fromJson(json['data'])
          : null,
    );
  }
}

class GetAdminOverviewData {
  int totalSuccessOrder;
  double totalRevenueInMonth;
  double totalRevenueInDay;
  int totalPendingTransactions;
  double totalPendingAmount;

  GetAdminOverviewData(
      {required this.totalSuccessOrder,
      required this.totalRevenueInMonth,
      required this.totalRevenueInDay,
      required this.totalPendingTransactions,
      required this.totalPendingAmount});

  factory GetAdminOverviewData.fromJson(Map<dynamic, dynamic> json) {
    return GetAdminOverviewData(
      totalSuccessOrder: json['totalSuccessOrder'],
      totalRevenueInMonth: json['totalRevenueInMonth'] / 1.0,
      totalRevenueInDay: json['totalRevenueInDay'] / 1.0,
      totalPendingTransactions: json['totalPendingTransactions'],
      totalPendingAmount: json['totalPendingAmount'] /1.0
    );
  }
}
