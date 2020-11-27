class OrderedProductModel{
  String name;
  String actual_price;
  String promation_price;
  String image;
  int itemCount;
  String item_cost;
  OrderedProductModel({this.name, this.actual_price, this.promation_price,this.image,this.itemCount,this.item_cost});

  OrderedProductModel.fromMap(Map snapshot):
        name = snapshot['name'] ?? '',
        actual_price=snapshot['actual_price']??'',
        promation_price=snapshot['promotion_price']?? '',
        image = snapshot['image'] ?? '',
        itemCount=snapshot['item_count']?? 0,
        item_cost=snapshot['item_cost']?? '';
  toJson(){
    return {
      "name": name,
      "image":image,
      "promotion_price":promation_price,
      "actual_price":actual_price,
      "item_cost":item_cost,
      "item_count":itemCount,
    };
  }
}