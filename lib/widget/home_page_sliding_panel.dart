import 'package:doemoring/widget/cardCatogries.dart';
import 'package:flutter/material.dart';

import 'daily_promation.dart';
class HomePageSlidingPanel extends StatelessWidget {
  final scrollController;
  final Function onNext;

  const HomePageSlidingPanel({Key key, this.scrollController, this.onNext}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          CardCatogries(onNext: onNext,),
          DailyPromation(onNext: onNext,),


        ],
      ),
    );
  }
}

