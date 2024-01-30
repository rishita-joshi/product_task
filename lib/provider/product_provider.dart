import 'package:core_techno/api/http_config.dart';
import 'package:core_techno/api/model/product_model.dart';
import 'package:core_techno/database/sql_database.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  DataBase dataBase = DataBase();
  List<Product> productList = [];
  List<Product> productCartList = [];
  int totalAmount = 0;

  getDataFromDatabase() async {
    productList = await dataBase.getProducts();
    print(productList);
    notifyListeners();
  }

  void addStock(int index, bool isCartPage) {
    if (isCartPage) {
      productCartList[index].quantity = productCartList[index].quantity! + 1;
    } else {
      dataBase.updateProduct(Product(quantity: productList[index].quantity! + 1));
      productList[index].quantity = productList[index].quantity! + 1;
    }

    notifyListeners();
  }

  void minusStock(int index, bool isCartPage) {
    if (isCartPage) {
      productCartList[index].quantity = productCartList[index].quantity! - 1;
    } else {
      productList[index].quantity = productList[index].quantity! - 1;
    }
    print(productList[index].quantity);

    notifyListeners();
  }

  void addToCart(int index) {
    totalAmount = 0;
    if (!productCartList.contains(productList[index])) {
      productCartList.add(productList[index]);
      for (int i = 0; i < productCartList.length; i++) {
        totalAmount = (productCartList[i].price! + totalAmount);
      }
    }

    notifyListeners();
  }
}
