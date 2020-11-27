import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/model/catagories_model.dart';
import 'package:doemoring/provider/CRUDModel.dart';
import 'package:doemoring/view/items_in_subCatagorie.dart';
import 'package:doemoring/view/make_order_page.dart';
import 'package:doemoring/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SubCatagorie extends StatefulWidget {

  final name;
  final Function onNext;

  const SubCatagorie({Key key, this.name, this.onNext}) : super(key: key);
  @override
  _SubCatagorieState createState() => _SubCatagorieState();
}

class _SubCatagorieState extends State<SubCatagorie> {
  @override
  Widget build(BuildContext context) {
    final apiProvider=Provider.of<CRUDModel>(context);
    List<CatagoriesModel> catagroies=[];
    print(widget.name);
//    catagroies.add(new CatagoriesModel('images/aungmoe.jpg', "Chicken"));
//    catagroies.add(new CatagoriesModel('images/thien.jpg', "Mutton"));
//    catagroies.add(new CatagoriesModel('images/hendrick.jpg', "Pork"));

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: ResuableAppBar.getAppBar(Colors.greenAccent, widget.name, context,widget.onNext),
      body: StreamBuilder(
        stream: apiProvider.FetchSubCatagories(widget.name),
        builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot){
          if(snapshot.hasData){
            catagroies=snapshot.data.documents
            .map((e) => CatagoriesModel.fromMap(e.data))
                .toList();
            return ListView.builder(
                itemCount: catagroies.length,
                itemBuilder:(BuildContext context,index){
                  return GestureDetector(
                    onTap:() {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>ItemsInSubCatagorie(subCatagroie_name:catagroies[index].name,onNext: widget.onNext,)));
                      },
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 10
                      ),
                      height: height/4,
                      child: Stack(
                        children: [
                          Image.network(catagroies[index].image,
                            width: width,
                            fit: BoxFit.cover,),
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 30
                              ),
                              width:width,
                              height: 50,
                              color: Colors.black.withOpacity(0.4),
                              child: Center(
                                child: Text(catagroies[index].name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } );
          }else{
            return CircularProgressIndicator();
          }

        },
      )


    );
  }
}
