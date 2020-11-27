
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/provider/CRUDModel.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:doemoring/model/product_model.dart';
import 'package:doemoring/widget/promation_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SearchAndListView extends StatefulWidget {

  final String name;
  final bool isCatagorie,isPromotion;
  final Function onNext;

  const SearchAndListView({Key key, this.name, this.isCatagorie, this.isPromotion, this.onNext}) : super(key: key);
  @override
  _SearchAndListViewState createState() => _SearchAndListViewState();
}

class _SearchAndListViewState extends State<SearchAndListView> {

  TextEditingController search_controller = new TextEditingController();
  List<ProductModel> product_lists = [];
  List<ProductModel> searchResult_list = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (widget.isPromotion == true) {
      _getPromotionItemsList();
    }
    else {
      _getProductList(widget.name, widget.isCatagorie);
    }
  }


  @override
  Widget build(BuildContext context) {
    final OrderedProdcutProvider = Provider.of<OrderedProductProvider>(context);

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    final double itemHeight = height / 2.2;
    final double itemWidth = width / 2.9;


    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        new Container(
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              child: new ListTile(
                leading: new Icon(Icons.search),
                title: new TextField(
                  controller: search_controller,
                  decoration: new InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                  onChanged: onSearchTextChanged,
                ),
                trailing: new IconButton(
                  icon: new Icon(Icons.cancel), onPressed: () {
                  search_controller.clear();
                  onSearchTextChanged('');
                },),
              ),
            ),
          ),
        ),
        new Container(
            child: searchResult_list.length != 0 ||
                search_controller.text.isNotEmpty
                ? GridView.count(
                padding: EdgeInsets.symmetric(
                    horizontal: 20
                ),
                crossAxisCount: 3,
                physics: ScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
                childAspectRatio: (itemWidth / itemHeight),
                shrinkWrap: true,
                children: List.generate(searchResult_list.length, (index) {
                  return Container(
                      height: height / 2.5,
                      child: PromotionCard(
                          product_list: searchResult_list[index]));
                })
            ) :
            product_lists.length != 0 ?
            GridView.count(
                padding: EdgeInsets.symmetric(
                    horizontal: 20
                ),
                physics: ScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
                childAspectRatio: (itemWidth / itemHeight),
                shrinkWrap: true,
                children: List.generate(product_lists.length, (index) {
                  var product = OrderedProdcutProvider.items.firstWhere((
                      product) =>
                  product.name ==
                      product_lists[index].name, orElse: () => null);

//                      if (product == null) {
                  return Container(
                      height: height / 2.5,
                      child: PromotionCard(product_list: product_lists[index],onNext: widget.onNext,));
                })
            ) : Center(child:Text("There Is No Data"))
        )
      ],
    );
  }

  void onSearchTextChanged(String text) {
    searchResult_list.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    product_lists.forEach((product_list) {
      if (product_list.name.toLowerCase().contains(text.toLowerCase()))
        searchResult_list.add(product_list);
    });

    setState(() {});
  }

  void _getProductList(String name, bool isCatagorie) {
    String whereCatagrie;
    whereCatagrie = isCatagorie == true ? "catagorie" : "sub_catagorie";
    Firestore.instance.collection('items')
        .where(whereCatagrie, isEqualTo: name)
        .snapshots()
        .listen((snap) {
      product_lists.clear();
      if (this.mounted) {
        setState(() {
          product_lists = snap.documents
              .map((e) => ProductModel.fromMap(e.data))
              .toList();
        });
      }
    });
  }


  void _getPromotionItemsList() {
    Firestore.instance.collection('items')
        .where("is_promotion", isEqualTo: true)
        .snapshots()
        .listen((snap) {
      product_lists.clear();
      if (this.mounted) {
        setState(() {
          product_lists = snap.documents
              .map((e) => ProductModel.fromMap(e.data))
              .toList();
        });
      }
    });

  }
}