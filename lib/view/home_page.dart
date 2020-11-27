import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/provider/app_bar_provider.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:doemoring/provider/phone_uniqueId_provider.dart';
import 'package:doemoring/widget/app_bar_widget.dart';
import 'package:doemoring/widget/home_page_sliding_panel.dart';
import 'package:doemoring/widget/image_slider_home_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
class HomePageView extends StatefulWidget {

  final Function onNext;

  const HomePageView({Key key, this.onNext}) : super(key: key);
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>{

  double _maxHeight;
  double _paddingValue;






  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    getUniqueId();
  }


  @override
  Widget build(BuildContext context) {

    Color _color;

    final appBarProvider=Provider.of<AppBarProvider>(context);
    if(appBarProvider.isMaxHeight==true){
      _color=Colors.greenAccent;
    }
    else {
      _color = Colors.transparent;
    }
    double height=MediaQuery.of(context).size.height;


    double appBarHeight = AppBar().preferredSize.height/height;
    _maxHeight= 1-appBarHeight;
    _paddingValue=appBarProvider.paddingValue;
    print(_maxHeight);

    return Scaffold(


       extendBodyBehindAppBar: true,
        appBar:ResuableAppBar.getAppBar(_color,"Doe Zay",context,widget.onNext),
      body: Stack(
          children: [
            ImageSliderHomePageView(onNext: widget.onNext,),
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (notifiaction){
                print(notifiaction.extent.toString());
                if(notifiaction.extent>_maxHeight){
                  appBarProvider.setMaxHeigh(true);
                  appBarProvider.setPaddingValue(0);
                }
                else{
                  appBarProvider.setMaxHeigh(false);
                  appBarProvider.setPaddingValue(20);
                }
              },
              child: DraggableScrollableSheet(
                maxChildSize: 1,
                minChildSize:0.7,
                initialChildSize: 0.7,
                builder: (BuildContext context, ScrollController scrollController){


                  return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: _paddingValue
                      ),
                      child: HomePageSlidingPanel(scrollController: scrollController,onNext: widget.onNext,));
    },
              ),
            )
//            SafeArea(
//              child: SlidingUpPanel(
//                renderPanelSheet: false,
//                color: Colors.white,
//                margin: EdgeInsets.symmetric(
//                  horizontal: _paddingValue
//                ),
//                maxHeight: _maxHeight,
//                minHeight:height/1.5,
//                parallaxEnabled: true,
//                parallaxOffset: .5,
//                onPanelSlide: (double pos){
//                  if(pos==1){
//                    appBarProvider.setMaxHeigh(true);
//                    print("true");
//                   appBarProvider.setPaddingValue(0);
//                  }
//                  else{
//                    appBarProvider.setMaxHeigh(false);
//                    appBarProvider.setPaddingValue(20);
//                  }},
//                panelBuilder: (sc) => HomePageSlidingPanel(scrollController: sc,),
//
//                ),
//            ),
          ],
        ),
      );
  }

  Future<void> getUniqueId() async {
    final idProvider=Provider.of<PhoneUniqueIdProvider>(context);
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    final String id=myPrefs.getString("id");
    if(id==null){
      myPrefs.setString("id", DateTime.now().millisecondsSinceEpoch.toString());
      idProvider.setUniqueId(myPrefs.getString("id"));
      print("id"+idProvider.uniqueId);
    }
    idProvider.setUniqueId(id);
    print("id"+idProvider.uniqueId);
  }

}
