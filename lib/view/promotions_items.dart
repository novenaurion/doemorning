import 'package:doemoring/widget/app_bar_widget.dart';
import 'package:doemoring/widget/search_and_listview.dart';
import 'package:flutter/material.dart';
class PromotionsItems extends StatefulWidget {

  final Function onNext;

  const PromotionsItems({Key key, this.onNext}) : super(key: key);
  @override
  _PromotionsItemsState createState() => _PromotionsItemsState();
}

class _PromotionsItemsState extends State<PromotionsItems> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: ResuableAppBar.getAppBar(Colors.greenAccent,"Promotions Items", context,widget.onNext),
    body: SingleChildScrollView(
    child: SearchAndListView(isPromotion: true,onNext:widget.onNext),
    ),
    );
  }
}
