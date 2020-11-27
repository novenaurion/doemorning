
import 'package:doemoring/provider/CRUDModel.dart';
import 'package:doemoring/provider/app_bar_provider.dart';
import 'package:doemoring/provider/button_navigation_provider.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:doemoring/provider/phone_uniqueId_provider.dart';
import 'package:doemoring/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

void main(){
  setupLoctor();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyHomePage());
  });

}
GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AppBarProvider(),),
            ChangeNotifierProvider(create: (context) => OrderedProductProvider()),
            ChangeNotifierProvider(create: (context) => CRUDModel()),
            ChangeNotifierProvider(create: (context) => ButtonNaviagationProvider()),
            ChangeNotifierProvider(create: (context)=> PhoneUniqueIdProvider())

          ],
          child: MaterialApp(
              navigatorKey: mainNavigatorKey,
              debugShowCheckedModeBanner: false,
              title: "Doe Zay",
              home:SplashScreenPage(),

          ),);
  }
}