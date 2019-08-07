import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pertani_shop/pages/cart_page.dart';
import 'package:pertani_shop/pages/login_page.dart';
import 'package:pertani_shop/pages/main_page.dart';
import 'package:pertani_shop/pages/product_detail_page.dart';
import 'package:pertani_shop/pages/product_page.dart';

GetIt getIt = new GetIt();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pertani Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        "/":(context)=>MainPage(),
        '/product':(context)=>ProductPage(),
        '/login':(context)=>LoginPage(),
        '/cart':(context)=>CartPage(),
        '/detail':(context)=>ProductDetailPage(),
      },
      initialRoute: "/product",
    );
  }
}
