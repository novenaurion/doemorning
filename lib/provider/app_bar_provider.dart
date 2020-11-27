import 'package:flutter/material.dart';

class AppBarProvider with ChangeNotifier{
  bool _isMaxHeight;
  double _paddingValue=20;


  double get paddingValue => _paddingValue;

  bool get isMaxHeight => _isMaxHeight;

  setMaxHeigh(bool height){
    _isMaxHeight=height;
    notifyListeners();
  }

  setPaddingValue(double value){
    _paddingValue=value;
    notifyListeners();
  }
}