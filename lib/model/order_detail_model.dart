import 'package:doemoring/model/ordered_product_model.dart';

class OrderedDetailModel {
  String customer_name;
  String total_cost;
  String address;
  String ph_number;
  String ordered_date;
  String delivery_date;
  String total_item;
  List items;
  String uniqueId;
  int timeInMilli;
  bool accept_delivery;


  OrderedDetailModel({this.customer_name, this.total_cost, this.address,this.total_item,this.ph_number,this.timeInMilli,
      this.ordered_date, this.delivery_date, this.items,this.accept_delivery,this.uniqueId});

  OrderedDetailModel.fromMap(Map snapshot):
      customer_name=snapshot['customer_name'] ?? '',
      total_cost=snapshot['total_cost'] ?? '',
      address=snapshot['address'] ?? '',
      ordered_date=snapshot['ordered_date'] ?? '',
      delivery_date=snapshot['delivery_date']?? '',
      timeInMilli=snapshot['timeInMilli']?? 0,
      ph_number=snapshot['ph_number']?? '',
      total_item=snapshot['total_item']?? '',
      uniqueId=snapshot['uniqueId']??'',
      accept_delivery=snapshot['accept_delivery']?? false,
      items=snapshot['items'].
        map((e) => OrderedProductModel.fromMap(e)).toList()?? [];

  toJson(){
    return {
      "customer_name": customer_name,
      "total_cost":total_cost,
      "ordered_date":ordered_date,
      "address":address,
      "delivery_date":delivery_date,
      "total_item":total_item,
      "items":items,
      "timeInMilli":timeInMilli,
      "uniqueId":uniqueId,
      "accept_delivery":accept_delivery,
      "ph_number":ph_number,
    };
  }

}