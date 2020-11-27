
import 'dart:convert';

import 'package:android_intent/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/model/order_detail_model.dart';
import 'package:doemoring/provider/button_navigation_provider.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:doemoring/provider/phone_uniqueId_provider.dart';
import 'package:doemoring/view/Bottom_order_page.dart';
import 'package:doemoring/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class MakeOrderPage extends StatefulWidget {
  static const String routeName="/makeorder";
  final int totalCost,totalItem;

  const MakeOrderPage({Key key, this.totalCost, this.totalItem}) : super(key: key);
  @override
  _MakeOrderPageState createState() => _MakeOrderPageState();
}

class _MakeOrderPageState extends State<MakeOrderPage> {


  DateTime initialDate=DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1);
  DateTime lastDate=DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+7);
  var formatter = new DateFormat('dd-MM-yyyy');




  final _formKey=GlobalKey<FormState>();
  final PermissionHandler permissionHandler = PermissionHandler();
  Map<PermissionGroup, PermissionStatus> permissions;


  TextEditingController date_controller = new TextEditingController();
  TextEditingController name_controller = new TextEditingController();
  TextEditingController location_controller = new TextEditingController();
  TextEditingController phoneNumber_controller = new TextEditingController();

  String location;
  String customer_name,delivery_date;
  String phone_number='09';
  String ordered_date;
  int totalCost;
  int itemLength;
  int delivery_fee;
  final RegExp phoneRegex = new RegExp(r'^[0-9\-\+]{9,15}$');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestLocationPermission();
    getUserLocation();
    ordered_date=formatter.format(DateTime.now());
    date_controller.value=TextEditingValue(
      text:formatter.format(initialDate)
    );
//
//    MobileNumber.listenPhonePermission((isPermissionGranted) {
//      if (isPermissionGranted) {
//        initMobileNumberState();
//      } else {}
//    });
//
//    initMobileNumberState();

    phoneNumber_controller.value=TextEditingValue(
      text: phone_number
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final orderedProductProvider=Provider.of<OrderedProductProvider>(context,);

    orderedProductProvider.getitemCost();

    totalCost=orderedProductProvider.totalitemCost;
    itemLength=orderedProductProvider.items.length;

  }

  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        title: Text("Order"),
        backgroundColor: Colors.greenAccent,
        ),
      body:Form(
        key:_formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //name formfield
            new Container(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    leading: Container(
                        width: width/4,
                        child: new Text("Name")),
                    title: Container(
                      width: width/1.5,
                      child: new TextFormField(
                        controller: name_controller,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        onSaved: (String  value){
                          setState(() {
                            customer_name=value;
                          });
                        },

                        decoration: new InputDecoration(
                            hintText: 'Enter Your Name',
                            border: InputBorder.none),

                      ),
                    ),
                  ),
                ),
              ),
            ),


            // phone numberr form field

            new Container(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    leading: Container(
                        width: width/4,
                        child: new Text("Phone Number")),
                    title: Container(
                      width: width/1.5,
                      child: new TextFormField(
                        controller: phoneNumber_controller,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty || value.length!=11 || value.substring(0,2)!="09" ||!phoneRegex.hasMatch(value)) {
                            return 'Please Enter Valid Phone Number';
                          }
                          return null;
                        },
                        onSaved: (String value){
                          setState(() {
                            phone_number=value;
                          });
                        },

                        decoration: new InputDecoration(
                            hintText: 'Enter Your Phone Number',
                            border: InputBorder.none),

                      ),
                    ),
                    trailing: Icon(Icons.phone_android),
                  ),
                ),
              ),
            ),

            //date form field
            new Container(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    leading: Container(
                        width:width/4,
                        child: new Text("Delivery Date")),
                    title: Container(
                      width: width/1.5,
                      child: new TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Delivery Date';
                          }
                          return null;
                        },
                        controller: date_controller,
                        onSaved: (String value){
                          setState(() {
                            delivery_date=value;
                          });
                        },
                        decoration: new InputDecoration(
                            border: InputBorder.none),

                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DateTime date = DateTime(1900);
                          date = await showDatePicker(
                              context: context,
                              initialDate:initialDate,
                              firstDate:initialDate,
                              lastDate: lastDate);

                          date_controller.text = formatter.format(date);
                        },

                      ),
                    ),
                    trailing: Icon(Icons.date_range),
                  ),
                ),
              ),
            ),

            new Container(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    leading: Container(
                        width:width/4,child: new Text("Location")),
                    title: Container(
                      width: width/1.5,
                      child: new TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter address';
                          }
                          return null;
                        },
                        controller: location_controller,
                        onSaved: (String value){
                          setState(() {
                            location=value;
                          });
                        },
                        decoration: new InputDecoration(
                             border: InputBorder.none),

                      ),
                    ),
                    trailing:  new Icon(Icons.location_on),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10
              ),
              width: width,
              child: FlatButton(
                child: Text("Order",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),),
                color: Colors.greenAccent,
                onPressed: (){
                  _saveOrder(context);
                },
              ),
            )
          ],

        ),
      )
    );
  }

   void getUserLocation() async {//call this async method from whereever you need
    String error;
    Position position;

    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
    } else{
      position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }

    final coordinates = new Coordinates(
        position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;

    print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    location_controller.value=TextEditingValue(
        text:first.addressLine
    );
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.location);
    if (granted!=true) {
      requestLocationPermission();
    }
    debugPrint('requestContactsPermission $granted');
    return granted;
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get gurrent location"),
                content:const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(child: Text('Ok'),
                      onPressed: () {
                        final AndroidIntent intent = AndroidIntent(
                            action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        getUserLocation();
                      })],
              );
            });
      }
    }
  }

  _saveOrder(BuildContext context) async {
    final orderProductProvider=Provider.of<OrderedProductProvider>(context,listen: false);
    final phoneUniqueIdProvider=Provider.of<PhoneUniqueIdProvider>(context,listen:false);
    _formKey.currentState.save();
    if(_formKey.currentState.validate()){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return Dialog(

              child: Container(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
      );
      OrderedDetailModel orderedDetailModel=new OrderedDetailModel(
        customer_name: customer_name,
        delivery_date: delivery_date,
        ordered_date: ordered_date,
        address:location,
        ph_number: phone_number,
        timeInMilli: DateTime.now().millisecondsSinceEpoch,
        accept_delivery: false,
        uniqueId:phoneUniqueIdProvider.uniqueId,
        total_cost: totalCost.toString(),
        total_item:itemLength.toString(),
        items:orderProductProvider.items.map((e) => e.toJson()).toList(),
      );


      await Firestore.instance.collection("orders").add(orderedDetailModel.toJson()).whenComplete((){
        Navigator.of(context, rootNavigator: true).pop('dialog');
        orderProductProvider.removeAllItems();
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePageView()));
        final nav_provider=Provider.of<ButtonNaviagationProvider>(context,listen: false);
        nav_provider.setIndex(2);

      }
      );
    }






  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String phoneNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      phoneNumber = await MobileNumber.mobileNumber;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      phone_number = phoneNumber;
    });
  }

}
