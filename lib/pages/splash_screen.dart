import 'package:core_techno/api/http_config.dart';
import 'package:core_techno/database/sql_database.dart';
import 'package:core_techno/pages/home_page.dart';
import 'package:core_techno/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:sqflite/sqflite.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final db = await DataBase().initializedDB();
    var count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM product_table'));
    if (count! > 0) {
      print("Data alredy inserted");
    } else {
      print("Data should to Insert");
      HttpConfig().getProduct();
    }
    Future.delayed(Duration(seconds: 8), () async {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()),
        ModalRoute.withName('/'),
      );
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.brown.shade200,
                    Colors.brown.shade900,
                  ],
                )),
                child: FlutterLogo())));
  }
}

// Center(child: FlutterLogo(size: 160.0)),