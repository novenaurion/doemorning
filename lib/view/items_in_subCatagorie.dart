import 'package:doemoring/widget/app_bar_widget.dart';
import 'package:doemoring/widget/search_and_listview.dart';
import 'package:flutter/material.dart';
class ItemsInSubCatagorie extends StatefulWidget {

  final String subCatagroie_name;

  final Function onNext;

  const ItemsInSubCatagorie({Key key, this.subCatagroie_name, this.onNext}) : super(key: key);
  @override
  _ItemsInSubCatagorieState createState() => _ItemsInSubCatagorieState();
}

class _ItemsInSubCatagorieState extends State<ItemsInSubCatagorie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResuableAppBar.getAppBar(Colors.greenAccent, widget.subCatagroie_name, context,widget.onNext),
      body: SingleChildScrollView(
        child: SearchAndListView(name: widget.subCatagroie_name,isCatagorie: false,),
      ),
    );
  }

}
