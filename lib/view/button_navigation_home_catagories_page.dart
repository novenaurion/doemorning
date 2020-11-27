import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/main.dart';
import 'package:doemoring/provider/app_bar_provider.dart';
import 'package:doemoring/provider/button_navigation_provider.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:doemoring/route/destination_bottom_nav_page_route.dart';
import 'package:doemoring/view/Bottom_order_page.dart';
import 'package:doemoring/view/bottom_nav_catagories.dart';
import 'package:doemoring/view/buttom_nav_view.dart';
import 'package:doemoring/view/home_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

import 'cart.dart';
class BottomNavigationHomeCatagoriesPage extends StatefulWidget {
  @override
  _BottomNavigationHomeCatagoriesPageState createState() => _BottomNavigationHomeCatagoriesPageState();
}

class _BottomNavigationHomeCatagoriesPageState extends State<BottomNavigationHomeCatagoriesPage> {

  int _selectedIndex;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final bottomnavprovider=Provider.of<ButtonNaviagationProvider>(context);
    _selectedIndex=bottomnavprovider.index;

    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_selectedIndex].currentState.maybePop();

        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home
              ),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.category
              ),
              label: 'Catagories',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.devices_other_sharp
              ),
              label: 'orders',
            ),
          ],
          onTap: (index) {
              bottomnavprovider.setIndex(index);

          },
        ),
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
          ],
        ),
      ),
    );
  }

  void _next() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
  }

  

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          HomePageView(onNext: _next,),
          BottomNavCatagories(onNext: _next),
          BottomOrderPage(onNext: _next),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }
}
//
//  int _currentIndex = 0;
//  Color _color;
//
//  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
//
//
//  @override
//  Widget build(BuildContext context) {
//    final buttonNavigationProvider = Provider.of<ButtonNaviagationProvider>(
//        context);
//    final _items = [
//      BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
//      BottomNavigationBarItem(label: 'Catagories', icon: Icon(Icons.category)),
//      BottomNavigationBarItem(
//          label: 'Orders', icon: Icon(Icons.local_post_office)),
//    ];
//
////      return Scaffold(
////        bottomNavigationBar: BottomNavigationBar(
////          items: _items,
////          currentIndex: buttonNavigationProvider.index,
////          onTap:onTapTapped,
////        ),
////      );
////
////
////
//////    return CustomScaffold(
//////      scaffold: Scaffold(
//////        resizeToAvoidBottomInset: false,
//////        bottomNavigationBar: BottomNavigationBar(
//////          items: _items,
//////          currentIndex: buttonNavigationProvider.index,
//////          onTap: (index) {
//////            navigatorKey.currentState.maybePop();
//////            buttonNavigationProvider.setIndex(index);
//////          },
//////        ),
//////        body: CustomNavigator(
//////          navigatorKey: navigatorKey,
//////          home: buttonNavigationProvider.index==0? HomePageView():buttonNavigationProvider.index==1?BottomNavCatagories():BottomOrderPage(),
//////          pageRoute: PageRoutes.materialPageRoute,
//////        ),
//////      ),
//////      children: [
//////        HomePageView(),
//////        BottomNavCatagories(),
//////        BottomOrderPage()
//////      ],
//////
//////
//////
//////    );
////    //    final List<Widget> _children = [
//////      HomePageView(appBarHeight: appBarhHigaht,),
//////      BottomNavCatagories(),
//////      HomePageView(),
//////    ];
//
//    return Scaffold(
//      resizeToAvoidBottomInset: false,
//      bottomNavigationBar: BottomNavigationBar(
//        onTap: onTabTapped,
//        selectedItemColor: Colors.greenAccent,
//        currentIndex:buttonNavigationProvider.index,
//        items:_items
//      ),
//
//      body: WillPopScope(
//        onWillPop: () async {
//          print(5);
//          if (_navigatorKey.currentState.canPop()) {
//            print(6);
//            _navigatorKey.currentState.pop();
//            return false;
//          }
//          else{
//            print(7);
//            return true;
//          }
//
//        },
//        child: SafeArea(
//            top: false,
//            child: IndexedStack(
//              index: buttonNavigationProvider.index,
//                children: allButtonNavBar.map<Widget>((ButtonNavbarItem buttonNavbarItem) {
//                  return Navigator(
////                    key: _navigatorKey,
//                    onGenerateRoute: (RouteSettings settings) {
//                      return MaterialPageRoute(
//                        builder: (BuildContext context) => ButtonNavView(currentIndex: buttonNavigationProvider.index,),
//                        settings: settings,
//                      );
//                    },
//
////      onGenerateRoute: (RouteSettings settings){
////        WidgetBuilder builder;
////        switch(settings.name){
////          case '/':
////            builder=(BuildContext context) => ButtonNavView(currentIndex: widget.currentIndex,);
////            break;
////        }
////        return MaterialPageRoute(
////
////          builder: builder,
////          settings: settings,
////        );
////      },
//                  );
//                }).toList(),
//            )),
//      ),
//    );
//  }
//    void onTabTapped(int index) {
//      final buttonNavigationProvider=Provider.of<ButtonNaviagationProvider>(context,listen: false);
//      buttonNavigationProvider.setIndex(index);
//    }
//}
