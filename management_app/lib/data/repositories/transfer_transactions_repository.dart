import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/requests/confirm_transfer_money_request.dart';
import 'package:management_app/data/responses/get_transfer_transaction_details.dart';
import 'package:management_app/data/responses/get_transfer_transactions_response.dart';
import 'package:management_app/data/responses/update_ingredient_response.dart';

class TransferTransactionRepository {
  Future<List<GetTransferTransactionsData>?> getTransferTransactions(
      BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url =
        "${GlobalVariable.url}/order/api/v1/TransferTransaction/Transactions";
    try {
      Response response = await get(Uri.parse(url), headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetTransferTransactionsResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }

    return null;
  }

  Future<GetTransferTransactionDetailsData?> getTransferTransactionDetails(
      String restaurantId, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url =
        "${GlobalVariable.url}/order/api/v1/TransferTransaction/Transactions/Details/$restaurantId";
    try {
      Response response = await get(Uri.parse(url), headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = GetTransferTransactionDetailsResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return responseData.data;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }

    return null;
  }

  Future<bool> confirmTransfer(
      ConfirmTransferMoneyRequest request, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url =
        "${GlobalVariable.url}/order/api/v1/TransferTransaction/Transactions";
    try {
      Response response = await put(Uri.parse(url),
          headers: headers, body: jsonEncode(request.toJson()));

      Map<String, dynamic> data = json.decode(response.body);
      var responseData = UpdateIngredientResponse.fromJson(data);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return true;
      }

      showSnackBar(context, responseData.statusText!);
    } catch (e) {
      showSnackBar(context, "An error has occurred");
      print(e.toString());
    }

    return false;
  }
}
