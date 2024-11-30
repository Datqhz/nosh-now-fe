// import 'dart:convert';

// import 'package:nosh_now_application/core/constants/global_variable.dart';
// import 'package:nosh_now_application/data/models/account.dart';
// import 'package:nosh_now_application/data/models/eater.dart';
// import 'package:nosh_now_application/data/models/manager.dart';
// import 'package:nosh_now_application/data/models/merchant.dart';
// import 'package:nosh_now_application/data/models/role.dart';
// import 'package:nosh_now_application/data/models/shipper.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> storeCurrentUser(
//     {Manager? manager,
//     Eater? eater,
//     Merchant? merchant,
//     Shipper? shipper}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String userJson = '';
//   if (manager != null) {
//     userJson = jsonEncode(manager.toJson());
//   } else if (eater != null) {
//     userJson = jsonEncode(eater.toJson());
//   } else if (merchant != null) {
//     userJson = jsonEncode(merchant.toJson());
//   } else {
//     userJson = jsonEncode(shipper!.toJson());
//   }
//   // print(userJson);
//   await prefs.setString('user', userJson);
// }

// Future<void> disposeUserInfo() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove("user");
// }

// Future<dynamic> getUser() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? userJson = await prefs.getString('user');
//   if (userJson == null) {
//     print('is null');
//     return null;
//   }
//   Map<String, dynamic> userMap = jsonDecode(userJson);
//   if (GlobalVariable.roleName == "Manager") {
//     return Manager.fromJson(userMap);
//   } else if (GlobalVariable.roleName == "Eater") {
//     return Eater.fromJson(userMap);
//   } else if (GlobalVariable.roleName == "Merchant") {
//     return Merchant.fromJson(userMap);
//   }
//   return Shipper.fromJson(userMap);
// }

// Future<void> storeToken(String token) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('token', token);
// }

// Future<String?> getToken() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? token = await prefs.getString('token');
//   return token;
// }

// Future<void> destroyToken() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove("token");
// }

// Future<void> storeAccount(Account account) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String accountJson = jsonEncode(account.toJson());
//   await prefs.setString('account', accountJson);
// }

// Future<void> destroyAccount() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove('account');
// }

// Future<Account?> getAccount() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? accountJson = await prefs.getString('account');
//   if (accountJson == null) {
//     return null;
//   }
//   Map<String, dynamic> accountMap = jsonDecode(accountJson);
//   return Account.fromJson(accountMap);
// }

// Future<void> storeRole(Role role) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String accountJson = jsonEncode(role.toJson());
//   await prefs.setString('role', accountJson);
// }

// Future<void> destroyRole() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove('role');
// }

// Future<Role?> getRole() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? roleJson = await prefs.getString('role');
//   if (roleJson == null) {
//     return null;
//   }
//   Map<String, dynamic> roleMap = jsonDecode(roleJson);
//   return Role.fromJson(roleMap);
// }
