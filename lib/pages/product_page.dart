import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pertani_shop/widgets/header.dart';
import 'package:pertani_shop/widgets/sliver_delegate.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key key}) : super(key: key);

  static const List<String> _filterString = [
    'Cari "Mekonga',
    'Kategori "Padi',
    'Harga 10000>100000'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    child: Container(
                      child: Header(),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.black38)]),
                    ),
                    maxHeight: 45,
                    minHeight: 45),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 5,
                          );
                        },
                        itemCount: _filterString.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                  )
                                ]),
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                onTap: () {},
                                splashColor: Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Center(
                                      child: Text(
                                    _filterString[index],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                              color: Colors.lightGreen,
                            ),
                          );
                        },
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black38)]),
                    ),
                    maxHeight: 30,
                    minHeight: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
