import 'package:flutter/foundation.dart';
import 'package:nosh_now_application/data/models/location.dart';

class LocationNotifier with ChangeNotifier{
  Location? _location;
  Location? get location => _location;

  void change(Location? location){
    _location = location;
    notifyListeners();
  }
  void init(Location? location){
    _location = location;
  }
}