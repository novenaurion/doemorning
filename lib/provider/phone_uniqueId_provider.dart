import 'package:flutter/material.dart';

class PhoneUniqueIdProvider with ChangeNotifier{
  String _uniqueId;

  String get uniqueId => _uniqueId;

  set uniqueId(String value) {
    _uniqueId = value;
  }

  setUniqueId(String id){
    _uniqueId=id;
    print(_uniqueId);
  }
}