import 'package:doemoring/model/order_detail_model.dart';
import 'package:doemoring/model/ordered_product_model.dart';
import 'package:doemoring/widget/app_bar_widget.dart';
import 'package:doemoring/widget/cart_items_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class CustomerOrderPage extends StatefulWidget {
  final OrderedDetailModel orderedDetailModel;

  const CustomerOrderPage({Key key, this.orderedDetailModel}) : super(key: key);
  @override
  _CustomerOrderPageState createState() => _CustomerOrderPageState();
}

class _CustomerOrderPageState extends State<CustomerOrderPage> {

  final currencyformat = new NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Order"),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
                child: ListView.builder(
                    itemCount: widget.orderedDetailModel.items.length,
                    itemBuilder: (context,index)=>

                         ItemsCard( widget.orderedDetailModel.items[index],)


                ),
              ),
            ),
            CardForCost(),
          ],
        ),
      ),
    );
  }

 Widget CardForCost() {
   return Padding(
     padding: const EdgeInsets.symmetric(
         horizontal: 20
     ),
     child: Card(
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Padding(
             padding: const EdgeInsets.symmetric(
                 horizontal: 20,
                 vertical: 10
             ),
             child: Row(
               mainAxisAlignment:MainAxisAlignment.spaceBetween,
               children: [
                 Text("Total Items",style:
                 TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.bold,

                 ),),
                 Text(widget.orderedDetailModel.total_item.toString()+" items",
                   style:
                   TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,

                   ),)
               ],
             ),
           ),
           Padding(

             padding: const EdgeInsets.symmetric(
                 horizontal: 20,
                 vertical: 10),
             child: Row(
               mainAxisAlignment:MainAxisAlignment.spaceBetween,
               children: [
                 Text("Item Costs",
                   style:
                   TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,

                   ),),
                 Text("${currencyformat.format(int.parse(widget.orderedDetailModel.total_cost))} Kyats",
                   style:
                   TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,

                   ),)
               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(
                 horizontal: 20,
                 vertical: 10),
             child: Row(
               mainAxisAlignment:MainAxisAlignment.spaceBetween,
               children: [
                 Text("Deliver Free",
                   style:
                   TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,

                   ),),Text("0",
                   style:
                   TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,

                   ),)

               ],
             ),
           ),
           Container(
             width: double.infinity,
             height: 1,
             color: Colors.black,
           ),
           Padding(
             padding: const EdgeInsets.symmetric(
                 horizontal: 20,
                 vertical: 10),
             child: Row(
               mainAxisAlignment:MainAxisAlignment.spaceBetween,
               children: [
                 Text("Total Cost",
                   style:
                   TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,

                   ),),
                 Text("${currencyformat.format(int.parse(widget.orderedDetailModel.total_cost))} Kyats",
                   style:
                   TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,

                   ),)
               ],
             ),
           ),
         ],
       ),
     ),
   );
 }

  Widget ItemsCard(OrderedProductModel product_list) {
    double width=MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(product_list.image,
              height: 100,
              width: width/4,
              fit: BoxFit.cover,),

            Container(
              width: width/2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(product_list.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                        ),

                        Text(product_list.itemCount.toString(),style:
                        TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),

                      ],
                    ),
                  ),
                  Flexible(

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child:Text("${currencyformat.format(int.parse(product_list.actual_price)  )} Kyats",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                        Flexible(child: Text("${currencyformat.format(int.parse(product_list.item_cost))} Kyats",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
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
