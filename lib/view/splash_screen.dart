import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'button_navigation_home_catagories_page.dart';
class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 2,
        navigateAfterSeconds:  BottomNavigationHomeCatagoriesPage(),
        title: new Text('Welcome to Doe Zay',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: new Image.asset("images/logo.jpg"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.greenAccent
    );
  }
}
