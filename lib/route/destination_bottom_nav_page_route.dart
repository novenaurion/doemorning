import 'package:doemoring/main.dart';
import 'package:doemoring/view/bottom_nav_catagories.dart';
import 'package:doemoring/view/buttom_nav_view.dart';
import 'package:doemoring/view/home_page.dart';
import 'package:doemoring/view/items_in_main_catagories.dart';
import 'package:flutter/material.dart';


class DestinationBottomNavPageRoute extends StatefulWidget {

  final currentIndex;

  const DestinationBottomNavPageRoute({Key key, this.currentIndex,}) : super(key: key);
  @override
  _DestinationBottomNavPageRouteState createState() => _DestinationBottomNavPageRouteState();
}

class _DestinationBottomNavPageRouteState extends State<DestinationBottomNavPageRoute> {
//  final GlobalKey _navigatorKey = GlobalKey<NavigatorState>();
//  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    print(widget.currentIndex);
    return Navigator(
//      key: mainNavigatorKey,
      initialRoute: '/',

        onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
        builder: (BuildContext context) => ButtonNavView(currentIndex: widget.currentIndex,),
        settings: settings,
      );
    },

//      onGenerateRoute: (RouteSettings settings){
//        WidgetBuilder builder;
//        switch(settings.name){
//          case '/':
//            builder=(BuildContext context) => ButtonNavView(currentIndex: widget.currentIndex,);
//            break;
//        }
//        return MaterialPageRoute(
//
//          builder: builder,
//          settings: settings,
//        );
//      },
    );
  }
}
