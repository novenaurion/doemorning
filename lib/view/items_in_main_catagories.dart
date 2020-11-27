import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/model/catagories_model.dart';
import 'package:doemoring/model/product_model.dart';
import 'package:doemoring/provider/CRUDModel.dart';
import 'package:doemoring/widget/app_bar_widget.dart';
import 'package:doemoring/widget/promation_card.dart';
import 'package:doemoring/widget/search_and_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ItemsInMainCatagories extends StatefulWidget {
  static const String routeName="/itemsInMainCatagories";
  final CatagoiresName;
  final Function onNext;


  const ItemsInMainCatagories({Key key, this.CatagoiresName, this.onNext}) : super(key: key);
  @override
  _ItemsInMainCatagoriesState createState() =>_ItemsInMainCatagoriesState();
}

class _ItemsInMainCatagoriesState extends State<ItemsInMainCatagories> {

  @override
  Widget build(BuildContext context) {



    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    final apiProvider=Provider.of<CRUDModel>(context);
    List<CatagoriesModel> catagories;




    return Scaffold(
      appBar: ResuableAppBar.getAppBar(Colors.greenAccent,widget.CatagoiresName,context,widget.onNext),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            StreamBuilder(
              stream: apiProvider.FetchCatagoriesByName(widget.CatagoiresName),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

                if(snapshot.hasData){
                  print(snapshot.data.documents.length);
                  catagories=snapshot.data.documents
                      .map((e) => CatagoriesModel.fromMap(e.data))
                      .toList();
                  return Container(
              height: height/4,
              child: Stack(
                children: [
                  Image.network(catagories[0].image,
                  width: width,
                  fit: BoxFit.cover,),
                  Center(
                    child: Container(
                      width:width,
                      color: Colors.black.withOpacity(0.4),
                      child: Text(catagories[0].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  )
                ],
              ),
            );}
                else{
                  return CircularProgressIndicator();
                }


              },
            ),

            SearchAndListView(name: widget.CatagoiresName,isCatagorie: true,onNext:widget.onNext),
          ],
        ),
      ),
    );
  }






  Future<bool> _onWillPop() async{
    Navigator.canPop(context);
  }
}


