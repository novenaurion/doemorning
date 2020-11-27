
import 'package:doemoring/model/ordered_product_model.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class CartItemsCard extends StatefulWidget {

  final OrderedProductModel product_list;

  const CartItemsCard({Key key, this.product_list}) : super(key: key);
  @override
  _CartItemsCardState createState() => _CartItemsCardState();


}

class _CartItemsCardState extends State<CartItemsCard> {


  final currencyformat = new NumberFormat("#,##0", "en_US");


  @override
  Widget build(BuildContext context) {

    double width= MediaQuery.of(context).size.width;
    final orderedProductProvider=Provider.of<OrderedProductProvider>(context);

//    setState(() {
//      itemCost+=int.parse(widget.product_list.actual_price)*widget.product_list.itemCount;
//    });
    return Container(
      width: width,
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(widget.product_list.image,
            height: 100,
            width: width/4,
            fit: BoxFit.cover,),

            Container(
              width: width/2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(widget.product_list.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                        Flexible(
                          child: Container(
                            width: 100,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                CircleAvatar(
                                  radius:14,
                                  child: IconButton(
                                    iconSize: 14,
                                    icon:Icon(Icons.remove),
                                    onPressed: (){

                                      orderedProductProvider.removeSingleItem(widget.product_list);

                                    },
                                  ),
                                ),
                                Text(widget.product_list.itemCount.toString()),
                                new CircleAvatar(
                                  radius: 14,
                                  child:IconButton(
                                  iconSize: 14,
                                    icon: new Icon(Icons.add),onPressed: (){


                                  orderedProductProvider.addItems(widget.product_list);
                                }

                                ),
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Flexible(

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child:Text("${currencyformat.format(int.parse(widget.product_list.actual_price)  )} Kyats",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                        Flexible(child: Text("${currencyformat.format(int.parse(widget.product_list.item_cost))} Kyats",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                      ],
                    ),
                  )
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }


}
