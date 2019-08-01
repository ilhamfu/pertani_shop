import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:pertani_shop/widgets/sliver_delegate.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                new _ProductPageBody(),
                // Positioned.fill(
                //     child: Container(
                //   color: Colors.black.withOpacity(0.5),
                // )),
                // AnimatedPositioned(
                //     bottom: 0,
                //     duration: Duration(milliseconds: 500),
                //     curve: Curves.easeIn,
                //     child: Container(
                //       height: 500,
                //       width: double.maxFinite,
                //       color: Colors.black,
                //     )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductPageBody extends StatelessWidget {
  const _ProductPageBody({
    Key key,
  }) : super(key: key);

  static const List<String> _filterString = [
    'Cari "Mekonga"',
    'Kategori "Padi"',
    'Harga 10000>100000'
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          floating: true,
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
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 1,
                                offset: Offset(1, 1))
                          ]),
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.green,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
        SliverPadding(
          padding: const EdgeInsets.all(2.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((ctx, index) {
              return ItemCard(index: index);
            }, childCount: 100),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 4,
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
          ),
        )
      ],
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  double pos = 0;
  bool showed = true;

  onDragUpdate(DragUpdateDetails dud) {
    if (dud.primaryDelta > 0 && showed) {
      setState(() {
        pos = math.min(pos + dud.primaryDelta, context.size.width);
      });
      return;
    }

    if (dud.primaryDelta < 0 && !showed) {
      setState(() {
        pos = math.max(pos + dud.primaryDelta, 0);
      });
      return;
    }
  }

  onDragEnd(DragEndDetails dsd) {
    if ((showed && dsd.primaryVelocity<0) || (!showed && dsd.primaryVelocity>0) ){
      return;
    }
    if (dsd.primaryVelocity.abs() > (1 / 3 * context.size.width)) {
      if (showed) {
        setState(() {
          pos = context.size.width;
          showed = false;
        });
      }else{
        setState(() {
          pos = 0;
          showed = true;
        });
      }
    }else{
      if (showed) {
        setState(() {
          pos = 0;
        });
      }else{
        setState(() {
          pos = context.size.width;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Dancuk ${widget.index}");
      },
      onHorizontalDragStart: (DragStartDetails dsd) {
        print(dsd.localPosition);
      },
      onHorizontalDragEnd: onDragEnd,
      onHorizontalDragUpdate: onDragUpdate,
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 100),
              left: pos,
              right: -pos,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://picsum.photos/id/${widget.index % 10 + 1}/300/400",
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black54,
                                Colors.black12,
                                Colors.transparent,
                              ],
                              stops: [
                                0.2,
                                0.4,
                                0.9
                              ])),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatefulWidget {
  const Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(2, 2, 2, 1),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                border: Border.all(color: Colors.green, width: 3)),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Expanded(
              child: TextField(
                  maxLines: 1,
                  focusNode: searchFocusNode,
                  decoration: InputDecoration(
                    hintText: "Search",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                  ))),
          !searchFocusNode.hasFocus
              ? Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  height: 33,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            "Filter",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
