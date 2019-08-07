import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key key, this.currentIndex})
      : super(key: key);
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    var buttonList = [
      {
        "label": "Produk",
        "icon": Icons.shopping_cart,
        "onTap": () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/product", ModalRoute.withName("/"));
        }
      },
      {
        "label": "Home",
        "icon": Icons.home,
        "onTap": () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/", ModalRoute.withName("/"));
        }
      },
      {
        "label": "Keranjang",
        "icon": Icons.shopping_cart,
        "onTap": () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/cart", ModalRoute.withName("/"));
        }
      },
      {"label": "User", "icon": Icons.person, "onTap": () {}},
    ];
    return _customOne(
        context: context, buttonList: buttonList, currentIndex: currentIndex);
  }

  BottomNavigationBar _default(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green,
      currentIndex: currentIndex,
      unselectedItemColor: Colors.green,
      selectedItemColor: Colors.orange,
      onTap: (index) {
        if (index == currentIndex) return;
        switch (index) {
          case 0:
            break;
          case 1:
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/", ModalRoute.withName("/"));
            break;
          case 2:
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/cart", ModalRoute.withName("/"));
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

  Widget _customOne(
      {BuildContext context, List<dynamic> buttonList, int currentIndex}) {
    return Container(
      height: kBottomNavigationBarHeight,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Row(
          children: buttonList
              .asMap()
              .map((index, button) => MapEntry(
                  index,
                  CustomBNBButton(
                    active: index == currentIndex,
                    button: button,
                    buttonLength: 4,
                  )))
              .values
              .toList()),
    );
  }
}

class CustomBNBButton extends StatelessWidget {
  const CustomBNBButton({
    Key key,
    @required this.button,
    @required this.buttonLength,
    @required this.active,
  }) : super(key: key);
  final Map<String, dynamic> button;
  final int buttonLength;
  final bool active;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width / buttonLength;
    return Container(
        width: w,
        child: Stack(
          children: <Widget>[
            Container(
                height: double.infinity,
                width: double.infinity,
                child: Material(
                  color: active ? Colors.white : Colors.green,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: !active?button["onTap"]:null,
                    child: Icon(
                      button["icon"],
                      color: !active ? Colors.white : Colors.black,
                    ),
                  ),
                )),
            Container(
              height: 5,
              width: double.infinity,
              color: active ? Colors.green : Colors.orange,
            ),
          ],
        ));
  }
}
