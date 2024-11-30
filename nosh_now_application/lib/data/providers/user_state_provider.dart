import 'package:flutter/material.dart';

class UserStateProvider with ChangeNotifier {
  bool _isLogin = false;

  get isLogin => _isLogin;

  void login(){
    _isLogin = true;
    notifyListeners();
  }
  void logout(){
    _isLogin = false;
    print("logout");
    notifyListeners();
  }
}
