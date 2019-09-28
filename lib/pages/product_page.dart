import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pertani_shop/models/product.dart';
import 'package:pertani_shop/utils/pertani_icon_icons.dart';
import 'package:pertani_shop/widgets/add_cart_modal.dart';
import 'package:pertani_shop/widgets/sliver_delegate.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class __HeaderState extends State<_Header> {
  FocusNode searchFocusNode = FocusNode();
  TextEditingController _searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff13DF4C),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: _searchController,
                maxLines: 1,
                onSubmitted: (value) {
                },
                focusNode: searchFocusNode,
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setWidth(7),
                      horizontal: ScreenUtil().setWidth(10)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                )),
          )),
          Container(
            width: 60,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(color: Color(0xff0FC442), width: 2),
                    right: BorderSide(color: Color(0xff0FC442), width: 2))),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: Center(
                    child: Icon(
                  PertaniIcon.filter_filled_tool_symbol,
                  color: Colors.white,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      setState(() {});
    });
  }
}

class _Header extends StatefulWidget {
  const _Header({Key key}) : super(key: key);

  @override
  __HeaderState createState() => __HeaderState();
}

class _ProductCard extends StatelessWidget {
  final int index;
  final Product product;
  const _ProductCard({
    Key key,
    @required this.index,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: product);
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            child: CachedNetworkImage(
              imageUrl: product.imageList[0] ?? "",
              errorWidget: (_, __, ___) =>
                  Image.asset("assets/product_placeholder.png"),
              placeholder: (_, __) =>
                  Image.asset("assets/product_placeholder.png"),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(5)),
                      width: double.infinity,
                      color: Color(0xff0FC442),
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          child: Text(
                            "${product.name}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(13),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                ),
                Container(
                  height: 3,
                  color: Colors.white,
                ),
                Expanded(
                  child: Container(
                    color: Color(0xff0FC442),
                    child: Row(
                      children: <Widget>[],
                    ),
                  ),
                  flex: 3,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ProductPageBody extends StatelessWidget {
  _ProductPageBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
            floating: true,
            delegate: CustomSliverDelegate(
                child: Container(
                  child: _Header(),
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black38)]),
                ),
                maxHeight: ScreenUtil().setHeight(50),
                minHeight: ScreenUtil().setHeight(50))),
        SliverPadding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
          sliver:SliverGrid(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                    return _SlidingProductCard(index:index);
                  }, childCount:5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 5,
                      crossAxisCount: 2,
                      crossAxisSpacing: ScreenUtil().setWidth(10),
                      mainAxisSpacing: ScreenUtil().setWidth(10)),
                )
              
        )
      ],
    );
  }

  Widget _buildFilterControl(
      {BuildContext context, Map<String, dynamic> filter}) {
    List<Map<String, dynamic>> _filterString = [];
    if ((filter["search"] ?? "") != "") {
      _filterString.add({
        "text": 'Nama "${filter["search"]}"',
        "tap": () {
        }
      });
    }
    if ((filter["category"]?.id ?? -1) > -1) {
      _filterString.add({
        "text": 'Category "${filter["category"].name}"',
        "tap": () {
        }
      });
    }

    if ((filter["star"] ?? 0) > 0) {
      _filterString.add({
        "text": 'Rating: ${filter["star"]} ke atas',
        "tap": () {
        }
      });
    }

    if (filter["price"]["min"] >= 0) {
      if (filter["price"]["max"] >= 0)
        _filterString.add({
          "text":
              'Harga: antara ${filter["price"]["min"]} sampai ${filter["price"]["max"]}',
          "tap": () {
          }
        });
      else
        _filterString.add({
          "text": 'Harga: lebih dari ${filter["price"]["min"]}',
          "tap": () {
            // Empty max
          }
        });
    } else {
      if (filter["price"]["max"] >= 0)
        _filterString.add({
          "text": 'Harga: kurang dari ${filter["price"]["max"]}',
          "tap": () {
            // Empty max
          }
        });
    }

    return _filterString.length == 0
        ? SliverToBoxAdapter(
            child: Container(),
          )
        : SliverPersistentHeader(
            pinned: true,
            delegate: CustomSliverDelegate(
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
                            onTap: () {
                              _filterString[index]["tap"]();
                            },
                            splashColor: Color(0xff0FC442),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(5)),
                              child: Center(
                                  child: Text(
                                _filterString[index]["text"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          color: Color(0xff0FC442),
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
          );
  }
}

class _ProductPageState extends State<ProductPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: Colors.white,
        child: new _ProductPageBody(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class _SlidingProductCard extends StatelessWidget {
  final int index;
  final Product product;

  const _SlidingProductCard({Key key, this.index, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, blurRadius: 1, offset: Offset(1, 1))
            ]),
        child: Slidable(
          child: _ProductCard(index: index, product: product),
          actionPane: SlidableBehindActionPane(),
          actions: index % 2 != 0
              ? <Widget>[
                  IconSlideAction(
                    color: Colors.orange,
                    foregroundColor: Colors.white,
                    icon: Icons.chat,
                    onTap: () {},
                  ),
                  IconSlideAction(
                    color: Color(0xff0FC442),
                    icon: Icons.add_shopping_cart,
                    onTap: () async {
                      var amount = (await showModalBottomSheet<int>(
                              builder: (ctx) {
                                return AddToCartWidget(
                                  product: product,
                                );
                              },
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10))))) ??
                          0;
                      if (amount == 0) return;

                    },
                  ),
                ]
              : [
                  IconSlideAction(
                    color: Colors.deepOrange,
                    icon: Icons.share,
                    onTap: () {},
                  ),
                ],
          secondaryActions: index % 2 == 0
              ? <Widget>[
                  IconSlideAction(
                    color: Color(0xff0FC442),
                    icon: Icons.add_shopping_cart,
                    onTap: () async {
                      var amount = await showModalBottomSheet<int>(
                              builder: (ctx) {
                                return AddToCartWidget(
                                  product: product,
                                );
                              },
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10)))) ??
                          0;
                      if (amount > 0) return;
                    },
                  ),
                  IconSlideAction(
                    color: Colors.orange,
                    foregroundColor: Colors.white,
                    icon: Icons.chat,
                    onTap: () {},
                  ),
                ]
              : [
                  IconSlideAction(
                    color: Colors.deepOrange,
                    icon: Icons.share,
                    onTap: () {},
                  ),
                ],
        ));
  }
}
