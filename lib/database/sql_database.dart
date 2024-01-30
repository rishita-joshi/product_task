import 'package:core_techno/api/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'product.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        return db.execute(
          'CREATE TABLE product_table(id INTEGER  ,  title TEXT, description TEXT , price INTEGER , discountPercentage REAL,rating REAL , stock INTEGER , brand TEXT, category TEXT , thumbnail TEXT, images TEXT , quantity INTEGER )',
        );
      },
    );
  }

  Future<int> insert(Product product) async {
    final db = await initializedDB();
    return await db.insert('product_table', product.toMap());
  }

  Future<List<Product>> getProducts() async {
    Database db = await initializedDB();
    List<Map<String, dynamic>> maps = await db.query('product_table');
    return List.generate(maps.length, (index) {
      return Product.fromMap(maps[index]);
    });
  }

  Future<void> updateProduct(Product product) async {
    final db = await initializedDB();
    await db.update(
      ' product_table',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
}
