import 'package:flutter/material.dart';
import 'package:management_app/core/constants/global_variable.dart';

class UserStateProvider with ChangeNotifier {
  bool _isLogin = false;

  get isLogin => _isLogin;

  void login() {
    _isLogin = true;
    notifyListeners();
  }

  void logout() {
    _isLogin = false;
    notifyListeners();
    GlobalVariable.profile = null;
    GlobalVariable.jwt = '';
  }
}
