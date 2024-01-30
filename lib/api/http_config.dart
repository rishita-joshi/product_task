import 'dart:convert';
import 'package:core_techno/api/model/product_model.dart';
import 'package:core_techno/database/sql_database.dart';
import 'package:http/http.dart' as http;

class HttpConfig {
  String apiUrl = "https://dummyjson.com/products";
  DataBase db = DataBase();

  Future<List<Product>> getProduct() async {
    List<Product> productList = [];
    var request = http.Request('GET', Uri.parse('https://dummyjson.com/products?limit=5'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var parsed = jsonDecode(await response.stream.bytesToString());
      ProductModel productModel = ProductModel.fromJson(parsed);
      for (int i = 0; i < productModel.products!.length; i++) {
        productList.add(productModel.products![i]);
        db.insert(productModel.products![i]);
      }
      return productList;
    } else {
      print(response.reasonPhrase);

      throw Exception(response.reasonPhrase);
    }
  }
}
