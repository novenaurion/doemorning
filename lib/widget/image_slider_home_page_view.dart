import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/model/catagories_model.dart';
import 'package:doemoring/provider/CRUDModel.dart';
import 'package:doemoring/provider/app_bar_provider.dart';
import 'package:doemoring/view/SubCatagorie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class ImageSliderHomePageView extends StatefulWidget {

  final Function onNext;

  const ImageSliderHomePageView({Key key, this.onNext}) : super(key: key);

  @override
  _ImageSliderHomePageViewState createState() => _ImageSliderHomePageViewState();
}

class _ImageSliderHomePageViewState extends State<ImageSliderHomePageView> {
  @override
  Widget build(BuildContext context) {
    final appBarProvider=Provider.of<AppBarProvider>(context);
    final apiProvider=Provider.of<CRUDModel>(context);
    double width = MediaQuery. of(context).size.width;
    double height = MediaQuery. of(context). size. height;

    List<CatagoriesModel> catagroies=[];
    catagroies.add(new CatagoriesModel('images/meat.jpg', "Meat"));
    catagroies.add(new CatagoriesModel('images/vegetables.jpg',"Vegetable"));
    catagroies.add(new CatagoriesModel('images/breakfast.jpeg', "Breakfast"));

    return  Opacity(
            opacity: appBarProvider.isMaxHeight==true? 0:1,
            child: SizedBox(
              height: height/3,
              width: width,
              child: new Swiper(

                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCatagorie(name:catagroies[index].name,onNext: widget.onNext,)));
                    },
                    child: Stack(
                      children: [
                        Image.asset(catagroies[index].image,
                          width: width,
                          fit: BoxFit.cover,),
                        Center(
                          child: Container(
                            width:width,
                            height:50,
                            color: Colors.black.withOpacity(0.4),
                            child: Center(
                              child: Text(catagroies[index].name,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },

                autoplay: true,
                itemCount: catagroies.length,

              ),
            ),
          );


  }


}
