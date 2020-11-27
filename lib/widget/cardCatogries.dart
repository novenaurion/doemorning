import 'package:doemoring/provider/app_bar_provider.dart';
import 'package:doemoring/provider/button_navigation_provider.dart';
import 'package:doemoring/view/items_in_main_catagories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CardCatogries extends StatefulWidget {

  final Function onNext;

  const CardCatogries({Key key, this.onNext}) : super(key: key);
  @override
  _CardCatogriesState createState() => _CardCatogriesState();
}

class _CardCatogriesState extends State<CardCatogries> {
  @override
  Widget build(BuildContext context) {

    final appBarProvider=Provider.of<AppBarProvider>(context);
    final buttonNavigationProvider=Provider.of<ButtonNaviagationProvider>(context);

    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;

    final _navigatorKey=GlobalKey<NavigatorState>();
    return Container(
      // Provide an optional curve to make the animation feel smoother.
      height: height/5,
      margin: appBarProvider.isMaxHeight==true?
      EdgeInsets.symmetric(horizontal: 20):
      EdgeInsets.symmetric(horizontal: 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10)
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _iconCatagoriesContainer(icon: Icons.ac_unit,name: "Meat",onTap: ()=>
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemsInMainCatagories(CatagoiresName: "Meat",onNext: widget.onNext,)))),
                _iconCatagoriesContainer(icon:Icons.ac_unit,name: "Raw",onTap: ()=>
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemsInMainCatagories(CatagoiresName: "Raw",onNext: widget.onNext)))),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _iconCatagoriesContainer(icon:Icons.ac_unit, name:"Vegeatable",onTap: ()=>
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        ItemsInMainCatagories(CatagoiresName: "Vegetable",onNext: widget.onNext)))),
                _iconCatagoriesContainer(icon:Icons.ac_unit, name:"Flowers",onTap: ()=>
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemsInMainCatagories(CatagoiresName: "Flowers",onNext: widget.onNext)))),

              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _iconCatagoriesContainer(icon:Icons.ac_unit, name:"Breakfast",onTap: ()=>
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemsInMainCatagories(CatagoiresName: "Breakfast",onNext: widget.onNext)))),
                _iconCatagoriesContainer(icon:Icons.ac_unit, name:"Catagories",onTap:(){
                    buttonNavigationProvider.setIndex(1);
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _iconCatagoriesContainer({IconData icon, String name, GestureTapCallback onTap}) {
    return GestureDetector(
      child: Column(

        children: [
          Icon(icon),
          Text(name),
        ],
      ),
      onTap: onTap,
    );
  }
}
