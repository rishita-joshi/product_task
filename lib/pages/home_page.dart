import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_techno/pages/add_to_cart_page.dart';
import 'package:core_techno/provider/product_provider.dart';
import 'package:core_techno/widget/stock_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getDataFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, providerObj, child) {
      print(providerObj.productList);
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Product List"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddtoCartPage()),
                  );
                },
                icon: Icon(Icons.shopping_cart))
          ],
        ),
        body: providerObj.productList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Expanded(
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: providerObj.productList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Card(
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(height: 90, width: 100, imageUrl: providerObj.productList[index].images![0].toString()),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                    width: 80,
                                                    child: Text(
                                                      providerObj.productList[index].title.toString(),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(),
                                                    ),
                                                  ),
                                                  Text(providerObj.productList[index].price.toString(), style: TextStyle()),
                                                ],
                                              ),
                                              providerObj.productList[index].quantity == 0
                                                  ? IconButton(
                                                      onPressed: () {
                                                        print("===>Click Index ${index}");
                                                        providerObj.addStock(index, false);
                                                        providerObj.addToCart(index);
                                                      },
                                                      icon: Icon(Icons.shopping_cart))
                                                  : StockWidget(
                                                      cartIndex: index,
                                                      quanity: providerObj.productList[index].quantity.toString(),
                                                      isCartPage: false,
                                                    )
                                            ]),
                                      ),
                                    ],
                                  ),
                                ))),
                  ],
                ),
              )
            : SizedBox(),
      );
    });
  }
}
