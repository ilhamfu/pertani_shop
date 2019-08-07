import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key key, this.currentIndex})
      : super(key: key);
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green,
      currentIndex: currentIndex,
      unselectedItemColor: Colors.green,
      selectedItemColor: Colors.orange,
      onTap: (index) {
        if (index==currentIndex)
          return;
        switch (index) {
          case 0:
            Navigator.of(context).popAndPushNamed("/product");
            break;
          case 1:
            Navigator.of(context).popAndPushNamed("/");
            break;
          case 2:
            break;
          case 3:
            break;
          default:
        }
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store), title: Text("Produk")),
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text("Keranjang")),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), title: Text("Saya")),
      ],
    );
  }
}
