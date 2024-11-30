import 'package:flutter/foundation.dart';
import 'package:nosh_now_application/data/models/order_detail.dart';
import 'package:nosh_now_application/data/responses/get_order_init_response.dart';

class OrderDetailNotifier with ChangeNotifier{
  OrderDetailData? _detail;
  OrderDetailData? get detail => _detail;
  int get amount => _detail!.amount ?? 0;

  
  void change(OrderDetailData? detail){
    _detail = detail;
    notifyListeners();
  }
  void init(OrderDetailData? detail){
    _detail = detail;
  }
}