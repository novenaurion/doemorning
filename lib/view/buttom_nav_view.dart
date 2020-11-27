import 'package:doemoring/view/Bottom_order_page.dart';
import 'package:doemoring/view/bottom_nav_catagories.dart';
import 'package:doemoring/view/home_page.dart';
import 'package:flutter/material.dart';
class ButtonNavView extends StatefulWidget {
  final currentIndex;

  const ButtonNavView({Key key, this.currentIndex}) : super(key: key);
  @override
  _ButtonNavViewState createState() => _ButtonNavViewState();
}

class _ButtonNavViewState extends State<ButtonNavView> {
  @override
  Widget build(BuildContext context) {

    print("Hello"+widget.currentIndex.toString());
    return widget.currentIndex==0?HomePageView():widget.currentIndex==1?BottomNavCatagories():BottomOrderPage();
  }
}
