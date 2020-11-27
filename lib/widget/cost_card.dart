import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doemoring/provider/ordered_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class CostCard extends StatefulWidget {
  @override
  _CostCardState createState() => _CostCardState();


}

class _CostCardState extends State<CostCard> {

  int totalitemCost;
  int totalCost;
  int itemLength;

  final currencyformat = new NumberFormat("#,##0", "en_US");



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();


    final orderedProductProvider=Provider.of<OrderedProductProvider>(context,listen: true);

    orderedProductProvider.getitemCost();

    totalitemCost=orderedProductProvider.totalitemCost;
    itemLength=orderedProductProvider.items.length;




  }

  @override
  Widget build(BuildContext context) {
    final orderedProductProvider=Provider.of<OrderedProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20
      ),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10
              ),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Items",style:
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,

                  ),),
                  Text(itemLength.toString()+"items",
                    style:
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                    ),)
                ],
              ),
            ),
            Padding(

              padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text("Item Costs",
                    style:
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                    ),),
                  Text("${currencyformat.format(totalitemCost)} Kyats",
                    style:
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                    ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text("Deliver Free",
                    style:
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                    ),),Text("0",
                        style:
                        TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,

                        ),)

                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Cost",
                    style:
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                    ),),
                  Text("${currencyformat.format(totalitemCost)} Kyats",
                    style:
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                    ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
