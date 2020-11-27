import 'dart:ui';
import 'package:doemoring/model/ordered_product_model.dart';
import 'package:doemoring/model/product_model.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:doemoring/view/item_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class PromotionCard extends StatefulWidget {
  final ProductModel product_list;
  final Function onNext;


   PromotionCard({Key key, this.product_list, this.onNext}) : super(key: key);

  @override
  _PromotionCardState createState() => _PromotionCardState();
}

class _PromotionCardState extends State<PromotionCard> {

  final currencyformat = new NumberFormat("#,##0", "en_US");


  int itemCount=1;


  @override
  Widget build(BuildContext context) {



    final orderedProductProvider= Provider.of<OrderedProductProvider>(context,listen: true);

    var product = orderedProductProvider.items.firstWhere((product) => product.name ==
        widget.product_list.name, orElse: () => null);
    //if product is not in cart list
    if(product==null){
      setState(() {
        itemCount=itemCount;
      });
    }

    else{
      setState(() {
        itemCount=product.itemCount;
      });
    }


    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    double photo_height=height  /4;



    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemDetailPage(product_list: widget.product_list,onNext: widget.onNext,)));
      },
      child: Container(
        color:  Colors.white,
            width: width/3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                        ),
                        child: Image.network(
                          widget.product_list.image,
                          width:width/3,
                          height:height/4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom:0,
                      left: 0,
                      right: 0,
                      //for promotion card
                      height: photo_height/3,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
                        child: Container(
                          width: width/3,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),

                          ),

                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(widget.product_list.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),),
                                Text("${currencyformat.format(int.parse(widget.product_list.promation_price))} Kyats",
                                  style: TextStyle(
                                    color: widget.product_list.is_promotion==false?Colors.red.withOpacity(0):
                                      Colors.red,
                                    fontSize:14,
                                    decorationColor: Colors.red,
                                    decoration: widget.product_list.is_promotion==false?TextDecoration.none:
                                        TextDecoration.lineThrough
                                  ),),
                                Text("${currencyformat.format(int.parse(widget.product_list.actual_price))} Kyats",
                                  style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize:14,
                                  ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 18,
                        child: IconButton(
                          iconSize: 18,
                          icon:Icon(Icons.remove),
                          onPressed: (){
                            if(product==null) {

                              if (itemCount != 1) {
                                setState(() {
                                  itemCount-=1;
                                });
                                print(itemCount);
                              }
                            }
                            else{
                              orderedProductProvider.removeSingleItem(product);
                            }
                          },
                        ),
                      ),
                      product==null?Text(itemCount.toString()): Text(product.itemCount.toString()),
                      new CircleAvatar(
                        radius: 18,
                        child:IconButton(
                          iconSize: 18,
                          icon: new Icon(Icons.add),onPressed: (){
                            if(product==null){
                                setState(() {
                                  itemCount+=1;
                                });
                                print(itemCount);
                            }
                            else{
                              orderedProductProvider.addItems(product);
                            }

                      }

                      ),)

                    ],
                  ),
                ),
                Container(

                  width: width/3,
                  child: FlatButton(

                    color: Colors.greenAccent,
                    child:product==null? Center(
                      child: Text("Add to Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,

                        ),),
                    ):Icon( Icons.done,
                      color: Colors.white,),
                    onPressed: (){
                      if(product==null){
                        orderedProductProvider.addItems(new OrderedProductModel(
                          name: widget.product_list.name,
                          actual_price: widget.product_list.actual_price,
                          promation_price: widget.product_list.promation_price,
                          image: widget.product_list.image,
                          itemCount: itemCount,
                          item_cost: (itemCount*int.parse(widget.product_list.actual_price)).toString()
                        ));
                      }
                      else{
                        orderedProductProvider.remove(product);
                      }
                      setState(() {
                          itemCount=1;
                          //if product remove from cart list, its item count =1
                      });
                    },
                  ),
                )
              ],
            ),
          ),
    );
  }
}
