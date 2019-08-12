import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pertani_shop/bloc/cart/bloc_layer/index.dart';
import 'package:pertani_shop/bloc/filter/bloc_layer/index.dart';
import 'package:pertani_shop/bloc/product/bloc_layer/index.dart';
import 'package:pertani_shop/models/cart.dart';
import 'package:pertani_shop/models/product.dart';
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
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(
              ScreenUtil().setWidth(2),
            ),
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
                  controller: _searchController,
                  maxLines: 1,
                  onSubmitted: (value) {
                    BlocProvider.of<FilterBloc>(context)
                        .dispatch(UpdateSearch(term: value));
                    setState(() {
                      _searchController.text = "";
                    });
                  },
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
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
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
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Hero(
                tag: product.id,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  placeholder: (context, data) {
                    return Container(
                      color: Colors.white,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorWidget: (context, title, data) {
                    return Container(
                      color: Colors.white,
                    );
                  },
                  imageUrl:
                      product.imageList.length > 0 ? product.imageList[0] : "",
                ),
              )),
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
                        0.5,
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
                          "Rp. ${product.price}",
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
                              "${product.avgRate}",
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
                  Column(
                    children: <Widget>[
                      Text(
                        "${product.name}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "Kategori",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(13)),
                              ),
                              Text(
                                "${product.category.name}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(13)),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Stock",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(13)),
                              ),
                              Text(
                                "${product.stock}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(13)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
        BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
          if (state is FilterSet)
            return _buildFilterControl(context: context, filter: state.toMap());
          return SliverToBoxAdapter(child: Container());
        }),
        SliverPadding(
          padding: const EdgeInsets.all(2.0),
          sliver:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductInitialized) {
              if (!state.isEmpty)
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                    return _SlidingProductCard(
                        index: index, product: state.products[index]);
                  }, childCount: state.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 4,
                      crossAxisCount: 2,
                      crossAxisSpacing: ScreenUtil().setWidth(5),
                      mainAxisSpacing: ScreenUtil().setWidth(5)),
                );
              else
                return SliverToBoxAdapter(
                  child: Container(
                      child: Center(
                          child: Text(
                    "Tidak Ada Produk",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                    ),
                  ))),
                );
            } else if (state is ProductFetching)
              return SliverToBoxAdapter(child: CircularProgressIndicator());

            return SliverToBoxAdapter(
              child: Container(
                  child: Center(
                      child: Text(
                "Error Saat Mengambil Produk",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                ),
              ))),
            );
          }),
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
          BlocProvider.of<FilterBloc>(context).dispatch(UpdateSearch(term: ""));
        }
      });
    }
    if ((filter["category"]?.id ?? -1) > -1) {
      _filterString.add({
        "text": 'Category "${filter["category"].name}"',
        "tap": () {
          BlocProvider.of<FilterBloc>(context)
              .dispatch(UpdateCategory(removeCategory: true));
        }
      });
    }

    if ((filter["star"] ?? 0) > 0) {
      _filterString.add({
        "text": 'Rating: ${filter["star"]} ke atas',
        "tap": () {
          BlocProvider.of<FilterBloc>(context).dispatch(UpdateStar(star: 0));
        }
      });
    }

    if (filter["price"]["min"] >= 0) {
      if (filter["price"]["max"] >= 0)
        _filterString.add({
          "text":
              'Harga: antara ${filter["price"]["min"]} sampai ${filter["price"]["max"]}',
          "tap": () {
            BlocProvider.of<FilterBloc>(context)
                .dispatch(UpdatePrice(max: -1, min: -1));
          }
        });
      else
        _filterString.add({
          "text": 'Harga: lebih dari ${filter["price"]["min"]}',
          "tap": () {
            // Empty max
            BlocProvider.of<FilterBloc>(context)
                .dispatch(UpdatePrice(max: -1, min: -1));
          }
        });
    } else {
      if (filter["price"]["max"] >= 0)
        _filterString.add({
          "text": 'Harga: kurang dari ${filter["price"]["max"]}',
          "tap": () {
            // Empty max
            BlocProvider.of<FilterBloc>(context)
                .dispatch(UpdatePrice(max: -1, min: -1));
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
                            splashColor: Colors.green,
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
          );
  }
}

class _ProductPageState extends State<ProductPage> {
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
                    color: Colors.green,
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
                                  top: Radius.circular(10))));
                      BlocProvider.of<CartBloc>(context).dispatch(CartCreate(
                          cart: Cart(
                              amount: amount,
                              product: product,
                              id: product.id)));
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
                    color: Colors.green,
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
                      if (amount > 0)
                        BlocProvider.of<CartBloc>(context).dispatch(CartCreate(
                            cart: Cart(
                                amount: amount,
                                product: product,
                                id: product.id)));
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
