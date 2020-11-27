import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/model/catagories_model.dart';
import 'package:doemoring/service/api.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';


class CRUDModel with ChangeNotifier {
  Api _api = locator<Api>();

  List<CatagoriesModel> catagories;

//  Future<List<CatagoriesModel>> fetchCatagories() async {
//    var result = await _api.getCatagories();
//    catagories = result.documents
//        .map((doc) => CatagoriesModel.fromMap(doc.data))
//        .toList();
//    return catagories;
//  }

  Stream<QuerySnapshot> FetchCatagoriesAsStream() {
    return _api.streamgetCatagories();
  }

  Stream<QuerySnapshot> FecthPromotionItemsAsStream(){
    return _api.streamgetPromotionItems();
  }

  Stream<QuerySnapshot> FetchSubCatagories(String name){
    return _api.streamGetSubCatagories(name);
  }
  Stream<QuerySnapshot> FetchCatagoriesByName(String name){
    return _api.streamGetCatagoriesByName(name);
  }

  Stream<QuerySnapshot> FetchOrdersByCustomerId(String id){
    return _api.streamOrderByCustomerId(id);
  }


}