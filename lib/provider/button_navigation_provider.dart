import 'package:flutter/material.dart';

class ButtonNaviagationProvider with ChangeNotifier{
  int _index=0;

  Function _onNext;

  Function get onNext => _onNext;


  set onNext(Function function){
    _onNext=function;
  }

  setOnNext(Function function){
    _onNext=function;
    notifyListeners();
  }

  int get index => _index;

  set index(int value) {
    _index = value;
  }

  setIndex(int i){
    _index=i;
    notifyListeners();
  }
}