import 'dart:convert';

import 'package:doemoring/model/catagories_model.dart';
import 'package:doemoring/provider/CRUDModel.dart';
import 'package:doemoring/view/items_in_subCatagorie.dart';
import 'package:doemoring/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class BottomNavCatagories extends StatefulWidget {


  final Function onNext;

  const BottomNavCatagories({Key key, this.onNext}) : super(key: key);
  @override
  _BottomNavCatagoriesState createState() => _BottomNavCatagoriesState();
}

class _BottomNavCatagoriesState extends State<BottomNavCatagories> {

  List<CatagoriesModel> catagories=[];
  @override
  Widget build(BuildContext context) {

    final apiProvider=Provider.of<CRUDModel>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar:ResuableAppBar.getAppBar(Colors.greenAccent,"Catagories",context,widget.onNext),
        backgroundColor: Colors.white,
        body: StreamBuilder(
          stream: apiProvider.FetchCatagoriesAsStream(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              print(snapshot.data);


              catagories=snapshot.data.documents
                  .map<CatagoriesModel>((e) => CatagoriesModel.fromMap(e.data))
                  .toList();
             return new ExpensionTileList(elementList: catagories,);
            }
            else{
              return const Center(
                child: const Text('Loading...'),
              );
            }
          },
        )
    );
  }
}

class ExpensionTileList extends StatelessWidget{

  final List<CatagoriesModel> elementList;

  const ExpensionTileList({Key key, this.elementList}) : super(key: key);

  List<Widget> _getChildren() {
    List<Widget> children = [];
    elementList.forEach((element) {
      children.add(
        new MyExpansionTile(name:element.name),
      );
    });
    return children;
  }
    @override
  Widget build(BuildContext context) {
      return new ListView(
        children: _getChildren(),
      );
    }
}

class MyExpansionTile extends StatefulWidget {

  final String name;

  const MyExpansionTile({Key key, this.name}) : super(key: key);
  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {

  PageStorageKey _key;

  @override
  Widget build(BuildContext context) {
    final apiProvider=Provider.of<CRUDModel>(context);
    return new ExpansionTile(
      title:Text(widget.name) ,
      children: [
        StreamBuilder(
          stream:apiProvider.FetchSubCatagories(widget.name),
          builder: (context,snapshot){
            if(snapshot.hasData){
              List<Widget> reasonList = [];
              List<CatagoriesModel> catagories=[];
              catagories=snapshot.data.documents
                  .map<CatagoriesModel>((e) => CatagoriesModel.fromMap(e.data))
                  .toList();
              catagories.forEach((element) {
                reasonList.add(GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>ItemsInSubCatagorie(subCatagroie_name: element.name,)));
                  },
                  child: new ListTile(
                    title: new Text(element.name),
                  ),
                ));
              });
              return new Column(children:reasonList,);
            }
            else{
            return const Center(
            child: const Text('Loading...'),
            );
          }
          },
        )
      ],
    );
  }
}
