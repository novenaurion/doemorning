import 'package:doemoring/model/ordered_product_model.dart';
import 'package:doemoring/model/product_model.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:doemoring/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class ItemDetailPage extends StatefulWidget {
  final ProductModel product_list;

  final Function onNext;


  const ItemDetailPage({Key key, this.product_list, this.onNext}) : super(key: key);
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {

  int itemCount=1;
  final currencyformat = new NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {

    final orderedProductProvider= Provider.of<OrderedProductProvider>(context);

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

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: ResuableAppBar.getAppBar(Colors.greenAccent, "Items Name", context,widget.onNext),
      body:   Column(
        children: [
          Container(
            height: height/3,
            child: Image.asset('images/hendrick.jpg',
              width: width,
              fit: BoxFit.cover,),
          ),
          // name and itemcount section
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text("Chicken Port of The Mighty Thor"+
                      "(${currencyformat.format(int.parse(widget.product_list.actual_price))} Kyats)",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                ),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
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
                    product==null?Text(itemCount.toString()): Text(product.itemCount.toString()),
                    new IconButton(
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

                    ),

                  ],
                ),
              ],
            ),
          ),
          // end of name and itemcount section

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10
              ),
              width: width,
              child: Text("how are you i hope you are well and happy.as for me i'm fine too.My name is Pyae Sone,I'm hot as hell.how are you i hope you are well and happy.as for me i'm fine too.My name is Pyae Sone,I'm hot as hell.",

                style: TextStyle(
                  letterSpacing: 1.0,
                fontSize: 16,
                color: Colors.black,
              ),),
            ),
          ),
          Container(

            width: width,
            child: FlatButton(

              color: Colors.greenAccent,
              child:product==null? Text("Add to Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,

                ),):Icon( Icons.done,
                color: Colors.white,),
              onPressed: (){
                if(product==null){
                  orderedProductProvider.addItems(new OrderedProductModel(
                      name: widget.product_list.name,
                      actual_price: widget.product_list.actual_price,
                      promation_price: widget.product_list.promation_price,
                      image: widget.product_list.image,
                      itemCount: itemCount
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
    );
  }
}
