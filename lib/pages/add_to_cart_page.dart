import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_techno/provider/product_provider.dart';
import 'package:core_techno/widget/stock_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddtoCartPage extends StatefulWidget {
  const AddtoCartPage({super.key});

  @override
  State<AddtoCartPage> createState() => _AddtoCartPageState();
}

class _AddtoCartPageState extends State<AddtoCartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, providerObj, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Add to Cart"),
        ),
        bottomNavigationBar: SizedBox(
          height: 200,
          child: Card(
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Price Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        providerObj.totalAmount.toString(),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: providerObj.productCartList.length > 0
            ? ListView.builder(
                itemCount: providerObj.productCartList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ListTile(
                      leading: CachedNetworkImage(imageUrl: providerObj.productCartList[index].images![0]),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(providerObj.productCartList[index].title ?? ""),
                          Text(providerObj.productCartList[index].price.toString() ?? ""),
                        ],
                      ),
                      trailing: SizedBox(
                          height: 50,
                          width: 100,
                          child:
                              // providerObj.productCartList[index].quantity! > 0
                              //     ?
                              StockWidget(
                            cartIndex: index,
                            quanity: providerObj.productCartList[index].quantity.toString(),
                            isCartPage: true,
                          )
                          //: SizedBox(),
                          ),
                    ),
                  );
                })
            : Center(
                child: Text(
                "Please Add Product",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
      );
    });
  }
}
