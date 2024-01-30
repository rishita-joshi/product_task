import 'package:core_techno/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockWidget extends StatefulWidget {
  const StockWidget({super.key, required this.cartIndex, required this.quanity, required this.isCartPage});

  final int cartIndex;
  final String quanity;
  final bool isCartPage;

  @override
  State<StockWidget> createState() => _StockWidgetState();
}

class _StockWidgetState extends State<StockWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, providerObj, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: IconButton(
                  onPressed: () {
                    providerObj.minusStock(widget.cartIndex, widget.isCartPage);
                  },
                  icon: const Icon(
                    Icons.remove,
                    size: 18,
                  )),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            widget.quanity.toString(),
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(color: Colors.white),
            child: IconButton(
                onPressed: () {
                  providerObj.addStock(widget.cartIndex, widget.isCartPage);
                },
                icon: Icon(
                  Icons.add,
                  size: 18,
                )),
          ),
        ],
      );
    });
  }
}
