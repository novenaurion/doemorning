import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/model/ordered_product_model.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:doemoring/view/make_order_page.dart';
import 'package:doemoring/widget/cart_items_card.dart';
import 'package:doemoring/widget/cost_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {



  @override
  Widget build(BuildContext context) {

    final orderedProductProvider=Provider.of<OrderedProductProvider>(context);



    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.greenAccent,
      ),
      body: orderedProductProvider.items.length!=0?

      Container(
        height: height,
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
                  itemCount: orderedProductProvider.items.length,
                  itemBuilder: (context,index)=>

                     CartItemsCard(product_list: orderedProductProvider.items[index],)


                ),
              ),
            ),
            CostCard(),


            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10
              ),
              width: width,
              child: FlatButton(
                child: Text("Order",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),),
                color: Colors.greenAccent,
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>MakeOrderPage()));
                },
              ),
            )
          ],
        ),
      ):Center(
        child: Text("There is no Items in Cart"),
      ),
    );
  }


}
