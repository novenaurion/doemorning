import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/model/order_detail_model.dart';
class Api{
  final  _db=Firestore.instance;

  Api(){

  }

//  Future<QuerySnapshot> getCatagories(){
//    return _db.collection('catagroies').getDocuments();
//  }

  Stream<QuerySnapshot> streamgetCatagories(){
    return _db.collection('catagroies').snapshots();
  }

  Stream<QuerySnapshot> streamgetPromotionItems(){
    return _db.collection('items').where('is_promotion',isEqualTo: true).snapshots();
  }

  Stream<QuerySnapshot> streamGetSubCatagories(String name){
    return _db.collection(name).snapshots();
  }

  Stream<QuerySnapshot> streamGetCatagoriesByName(String name){
    return _db.collection('catagroies').where('name',isEqualTo: name).snapshots();
  }
  
  Stream<QuerySnapshot> streamOrderByCustomerId(String id){
    return _db.collection("orders").where("uniqueId",isEqualTo: id).snapshots();
  }





}