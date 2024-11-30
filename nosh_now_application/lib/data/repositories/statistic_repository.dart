import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nosh_now_application/core/constants/global_variable.dart';
import 'package:nosh_now_application/data/models/top_food.dart';

class StatisticRepository {
  Future<double> getRevenueOfMerchantByTime(
      int merchantId, int option, DateTime time) async {
    // option = {1,2,3} - 1 is by date, 2 is by month, 3 is by year
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url =
        "${GlobalVariable.url}/api/statistic/calc-revenue/merchant?merchantId=$merchantId&";
    if (option == 1) {
      url += 'date=${DateFormat('yyyy-MM-dd').format(time)}';
    } else {
      url += 'year=${time.year}';
      if (option == 2) {
        url += '&month=${time.month}';
      }
    }
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: headers);
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw Exception("Something wrong when request to get data");
      }
      Map<String, dynamic> data = json.decode(response.body);
      print(response.body);
      return data['total'] / 1.0;
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to get data');
    }
  }

  Future<double> getEanrningOfShipperByTime(
      int shipperId, int option, DateTime time) async {
    // option = {1,2,3} - 1 is by date, 2 is by month, 3 is by year
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url =
        "${GlobalVariable.url}/api/statistic/calc-earning/shipper?shipperId=$shipperId&";
    if (option == 1) {
      url += 'date=${DateFormat('yyyy-MM-dd').format(time)}';
    } else {
      url += 'year=${time.year}';
      if (option == 2) {
        url += '&month=${time.month}';
      }
    }
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: headers);
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw Exception("Something wrong when request to get data");
      }
      Map<String, dynamic> data = json.decode(response.body);
      print(response.body);
      return data['total'] / 1.0;
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to get data');
    }
  }

  Future<int> getTotalOrderOfUserByTimeAndRole(
      int userId, int roleId, int option, DateTime time) async {
    // option = {1,2,3} - 1 is by date, 2 is by month, 3 is by year
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url =
        "${GlobalVariable.url}/api/statistic/count-order/user?userId=$userId&roleId=$roleId&";
    if (option == 1) {
      url += 'date=${DateFormat('yyyy-MM-dd').format(time)}';
    } else {
      url += 'year=${time.year}';
      if (option == 2) {
        url += '&month=${time.month}';
      }
    }
    try {
      Response response = await get(Uri.parse(url), headers: headers);
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw Exception("Something wrong when request to get data");
      }
      Map<String, dynamic> data = json.decode(response.body);
      return data['count'];
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to get data');
    }
  }

  Future<int> getTotalOrderByTime(int option, DateTime time) async {
    // option = {1,2,3} - 1 is by date, 2 is by month, 3 is by year
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url = "${GlobalVariable.url}/api/statistic/count-order?";
    if (option == 1) {
      url += 'date=${DateFormat('yyyy-MM-dd').format(time)}';
    } else {
      url += 'year=${time.year}';
      if (option == 2) {
        url += '&month=${time.month}';
      }
    }
    try {
      Response response = await get(Uri.parse(url), headers: headers);
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw Exception("Something wrong when request to get data");
      }
      Map<String, dynamic> data = json.decode(response.body);
      return data['count'];
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to get data');
    }
  }

  Future<double> getTotalTransaction(int option, DateTime time) async {
    // option = {1,2,3} - 1 is by date, 2 is by month, 3 is by year
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url = "${GlobalVariable.url}/api/statistic/calc-transaction?";
    if (option == 1) {
      url += 'date=${DateFormat('yyyy-MM-dd').format(time)}';
    } else {
      url += 'year=${time.year}';
      if (option == 2) {
        url += '&month=${time.month}';
      }
    }
    try {
      Response response = await get(Uri.parse(url), headers: headers);
      int statusCode = response.statusCode;
      // print(response.body);
      if (statusCode != 200) {
        throw Exception("Something wrong when request to get data");
      }
      Map<String, dynamic> data = json.decode(response.body);
      return data['total'] / 1.0;
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to get data');
    }
  }

  Future<int> getNumOfNewUser(int roleId, int option, DateTime time) async {
    // option = {1,2,3} - 1 is by date, 2 is by month, 3 is by year
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url =
        "${GlobalVariable.url}/api/statistic/count-account?roleId=$roleId&";
    if (option == 1) {
      url += 'date=${DateFormat('yyyy-MM-dd').format(time)}';
    } else {
      url += 'year=${time.year}';
      if (option == 2) {
        url += '&month=${time.month}';
      }
    }
    try {
      Response response = await get(Uri.parse(url), headers: headers);
      int statusCode = response.statusCode;
      print(response.body);
      if (statusCode != 200) {
        throw Exception("Something wrong when request to get data");
      }
      Map<String, dynamic> data = json.decode(response.body);
      return data['count'];
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to get data');
    }
  }

  Future<List<TopFood>> getTop5FoodBestSelling(
      int merchantId, int option, DateTime time) async {
    // option = {1,2,3} - 1 is by date, 2 is by month, 3 is by year
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer ${GlobalVariable.jwt}"
    };
    String url =
        "${GlobalVariable.url}/api/statistic/top-food?merchantId=$merchantId&";
    if (option == 1) {
      url += 'date=${DateFormat('yyyy-MM-dd').format(time)}';
    } else {
      url += 'year=${time.year}';
      if (option == 2) {
        url += '&month=${time.month}';
      }
    }
    try {
      Response response = await get(Uri.parse(url), headers: headers);
      int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw Exception("Something wrong when request to get data");
      }
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => TopFood.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to get data');
    }
  }
}
