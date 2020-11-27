import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/model/product_model.dart';
import 'package:doemoring/provider/CRUDModel.dart';
import 'package:doemoring/provider/app_bar_provider.dart';
import 'package:doemoring/view/promotions_items.dart';
import 'package:doemoring/widget/promation_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
class DailyPromation extends StatefulWidget {
  final Function onNext;

  const DailyPromation({Key key, this.onNext}) : super(key: key);
  @override
  _DailyPromationState createState() => _DailyPromationState();
}

class _DailyPromationState extends State<DailyPromation> {


  @override
  Widget build(BuildContext context) {
    final appBarProvider= Provider.of<AppBarProvider>(context);
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;

    return Container(
      height: height/2,
      margin:EdgeInsets.symmetric(
        vertical: 20
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         Container(
              margin:appBarProvider.isMaxHeight==true?
              EdgeInsets.symmetric(horizontal: 20):
              EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Daily Promation",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>PromotionsItems()));
                    },
                    child: Text("See All",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                  )
                ],

              ),
            ),

          DailyPromationListView(context)
        ],
      ),
    );
  }

  Widget DailyPromationListView(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    final appBarProvider= Provider.of<AppBarProvider>(context);
    final apiProvider=Provider.of<CRUDModel>(context);
    List<ProductModel> product_list;

    return Container(
      height: height/2.5,
      width: width,
      child:StreamBuilder(
        stream: apiProvider.FecthPromotionItemsAsStream(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

        if(snapshot.hasData){
          print(snapshot.data.documents.length);
          product_list=snapshot.data.documents
              .map((e) => ProductModel.fromMap(e.data))
              .toList();

            return ListView.separated(
              padding:appBarProvider.isMaxHeight==true?
              EdgeInsets.only(left: 20):EdgeInsets.symmetric(horizontal: 0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: product_list.length,
              itemBuilder: (BuildContext context,int index){
                return PromotionCard(product_list:product_list[index],onNext: widget.onNext,);
//              return Text(snapshot.data.documents[index].data.toString());
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 10,

                );
              },
            );
        }
        else{
          return Center(child: CircularProgressIndicator());
        }

        }

      )

    );
  }
}
