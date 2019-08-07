import 'package:flutter/material.dart';
import 'package:pertani_shop/widgets/custom_bottom.dart';
import 'package:pertani_shop/widgets/custom_scaffold.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),

      body: Container(),
    );
  }
}