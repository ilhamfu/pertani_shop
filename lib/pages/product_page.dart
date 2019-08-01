import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 360, height: 640, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      endDrawer: Drawer(
        child: Container(color: Colors.black,),
      ),
      backgroundColor: Colors.green,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.white,
            child: new _ProductPageBody(),
          ),
        ),
      ),
    );
  }
}

class _ProductPageBody extends StatelessWidget {
  const _ProductPageBody({
    Key key,
    this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

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
                maxHeight: ScreenUtil().setHeight(45),
                minHeight: ScreenUtil().setHeight(45))),
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverAppBarDelegate(
              child: Container(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setWidth(5),
                      horizontal: ScreenUtil().setWidth(5)),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: ScreenUtil().setWidth(5),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(5)),
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
              maxHeight: ScreenUtil().setHeight(30),
              minHeight: ScreenUtil().setHeight(30)),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(2.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((ctx, index) {
              return SlidingProductCard(
                index: index,
              );
            }, childCount: 100),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 4,
                crossAxisCount: 2,
                crossAxisSpacing: ScreenUtil().setWidth(5),
                mainAxisSpacing: ScreenUtil().setWidth(5)),
          ),
        )
      ],
    );
  }
}

class SlidingProductCard extends StatefulWidget {
  const SlidingProductCard({Key key, this.index,})
      : super(key: key);
  final int index;
  @override
  _SlidingProductCardState createState() => _SlidingProductCardState();
}

class _SlidingProductCardState extends State<SlidingProductCard> {
  double pos = 0;
  bool showed = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    if ((showed && dsd.primaryVelocity < 0) ||
        (!showed && dsd.primaryVelocity > 0)) {
      return;
    }
    if (dsd.primaryVelocity.abs() > (1 / 3 * context.size.width)) {
      if (showed) {
        setState(() {
          pos = context.size.width;
          showed = false;
        });
      } else {
        setState(() {
          pos = 0;
          showed = true;
        });
      }
    } else {
      if (showed) {
        setState(() {
          pos = 0;
        });
      } else {
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
        
      },
      onHorizontalDragEnd: onDragEnd,
      onHorizontalDragUpdate: onDragUpdate,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 1, offset: Offset(2, 2))
        ]),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new ProductCardControl(),
            AnimatedPositioned(
              duration: Duration(milliseconds: 100),
              left: pos,
              right: -pos,
              child: new _ProductCard(index: widget.index),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCardControl extends StatelessWidget {
  const ProductCardControl({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(40),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Tersedia",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "20000",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      width: ScreenUtil().setWidth(70),
                      height: ScreenUtil().setWidth(70),
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.orange,
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.white,
                          child: Icon(
                            Icons.chat,
                            size: ScreenUtil().setWidth(50),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        width: ScreenUtil().setWidth(70),
                        height: ScreenUtil().setWidth(70),
                        child: Material(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.orange,
                          child: InkWell(
                            onTap: () {},
                            splashColor: Colors.white,
                            child: Icon(
                              Icons.add_shopping_cart,
                              size: ScreenUtil().setWidth(50),
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
                Row(
                  children: <Widget>[],
                )
              ],
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: "https://picsum.photos/id/${index % 10 + 1}/300/400",
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
          ),
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(5),
                  vertical: ScreenUtil().setWidth(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(5),
                            vertical: ScreenUtil().setWidth(1)),
                        width: ScreenUtil().setWidth(95),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            border: Border.all(
                                color: Colors.deepOrange,
                                width: ScreenUtil().setWidth(2)),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "Rp. 6000000",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(13),
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(5),
                            vertical: ScreenUtil().setWidth(1)),
                        width: ScreenUtil().setWidth(50),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            border: Border.all(
                                color: Colors.deepOrange,
                                width: ScreenUtil().setWidth(2)),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "5.0",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(13),
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.w700),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrange,
                              size: ScreenUtil().setWidth(15),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "This is the name of productasdasdas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
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
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(2),
                ScreenUtil().setWidth(2),
                ScreenUtil().setWidth(2),
                ScreenUtil().setWidth(2)),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                border: Border.all(
                    color: Colors.green, width: ScreenUtil().setWidth(3))),
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
                    contentPadding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(7),
                        horizontal: ScreenUtil().setWidth(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                  ))),
          !searchFocusNode.hasFocus
              ? Container(
                  margin:
                      EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), 0, 0, 0),
                  height: ScreenUtil().setHeight(33),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {Scaffold.of(context).openEndDrawer();},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
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
