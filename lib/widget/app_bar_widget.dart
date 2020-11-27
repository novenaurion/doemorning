import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:doemoring/view/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResuableAppBar{


  static getAppBar(Color color,String title, BuildContext context,Function onNext){
    final orderedProductProvider=Provider.of<OrderedProductProvider>(context);
    return AppBar(
      backgroundColor:color,
      title: Text(title,overflow: TextOverflow.ellipsis,),
      actions: [

        new Padding(padding: const EdgeInsets.all(10.0),
          child:Container(
                  height: 150.0,
                  width: 30.0,
                  child: new GestureDetector(
                    onTap: onNext,

                    child: new Stack(

                      children: <Widget>[
                        new IconButton(icon: new Icon(Icons.shopping_cart,
                          color: Colors.white,),
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Cart()));
                          },
                        ),
                        orderedProductProvider.items.length ==0 ? new Container() :
                        new Positioned(

                            child: new Stack(
                              children: <Widget>[
                                new Icon(
                                    Icons.brightness_1,
                                    size: 20.0, color: Colors.green[800]),
                                new Positioned(
                                    top: 3.0,
                                    right: 4.0,
                                    child: new Center(
                                      child: new Text(
                                        orderedProductProvider.items.length.toString(),
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    )),
                              ],
                            )),
                      ],
                    ),
                  )
              )
        )
      ],
      elevation: 0,
    );
  }
}
