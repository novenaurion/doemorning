import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/model/order_detail_model.dart';
import 'package:doemoring/model/ordered_product_model.dart';
import 'package:doemoring/provider/CRUDModel.dart';
import 'package:doemoring/provider/phone_uniqueId_provider.dart';
import 'package:doemoring/view/CustomersOrderPage.dart';
import 'package:doemoring/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
class BottomOrderPage extends StatefulWidget {

  final Function onNext;

  const BottomOrderPage({Key key, this.onNext}) : super(key: key);
  @override
  _BottomOrderPageState createState() => _BottomOrderPageState();
}

class _BottomOrderPageState extends State<BottomOrderPage> {

  @override
  Widget build(BuildContext context) {

    final apiProvider=Provider.of<CRUDModel>(context);
    final idProvider=Provider.of<PhoneUniqueIdProvider>(context);

    List<OrderedDetailModel> orderDetial=[];

    return Scaffold(
      appBar: ResuableAppBar.getAppBar(Colors.greenAccent, "Orders", context,widget.onNext),
      body: StreamBuilder(
        stream: apiProvider.FetchOrdersByCustomerId(idProvider.uniqueId),
        builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.data!=null){
            orderDetial=snapshot.data.documents
                .map((e) => OrderedDetailModel.fromMap(e.data)).toList();
            return ListView.builder(
                itemCount: orderDetial.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerOrderPage(orderedDetailModel: orderDetial[index],)));
                    },
                    child: Card(
                      color: Colors.greenAccent,
                      child: ListTile(
                        title: Text("Your Order from ${orderDetial[index].ordered_date}",),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                });
          }
          else if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return Center(
              child: Text("You Ordered Nothing"),
            );
          }
        },

      ),
    );



  }
}
