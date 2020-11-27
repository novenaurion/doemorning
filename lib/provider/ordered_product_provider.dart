import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/model/ordered_product_model.dart';
import 'package:doemoring/model/product_model.dart';
import 'package:flutter/material.dart';

class OrderedProductProvider with ChangeNotifier {
  final List<OrderedProductModel> _items = [];

  int _totalCost;
  int _totalitemCost;


  int get totalitemCost => _totalitemCost;

  set itemCost(int value) {
    _totalitemCost = value;
  }

  int get totalCost => _totalCost;

  List<OrderedProductModel> get items => _items;

  Future<void>  getitemCost() async {
    _totalitemCost=0;
    if(_items.length!=0){

      for(int i=0;i<_items.length; i++){
        _totalitemCost+=int.parse(_items[i].actual_price)*_items[i].itemCount;

      }
    }
  }

  void getTotalCost(){

    _totalCost=0;
    _totalCost=_totalitemCost;
    notifyListeners();
  }




  void addItems(OrderedProductModel item){
    if(_items.contains(item)){
      int index=_items.indexOf(item);
      print(index.toString());
      _items[index].itemCount++;
      _items[index].item_cost=(int.parse(_items[index].actual_price)*_items[index].itemCount).toString();
      notifyListeners();
    }
    else{
      _items.add(item);
      notifyListeners();
    }
  }

  void removeSingleItem(OrderedProductModel item){
    if(_items.contains(item)){

      if(item.itemCount>1){
        int index=_items.indexOf(item);
        _items[index].itemCount--;
        _items[index].item_cost=(int.parse(_items[index].actual_price)*_items[index].itemCount).toString();
        notifyListeners();
      }
      else{
        _items.remove(item);
        notifyListeners();
      }


      notifyListeners();
    }
  }

  void removeAllItems(){
    _items.clear();
  }
  void remove(OrderedProductModel item){
    _items.remove(item);
    notifyListeners();
  }
}