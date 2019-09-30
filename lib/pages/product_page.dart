import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pertani_shop/bloc/filter_bloc/index.dart';
import 'package:pertani_shop/bloc/filter_bloc/states.dart';
import 'package:pertani_shop/bloc/product_list/bloc/index.dart';
import 'package:pertani_shop/models/product.dart';
import 'package:pertani_shop/utils/pertani_icon_icons.dart';
import 'package:pertani_shop/widgets/add_cart_modal.dart';

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
      decoration: BoxDecoration(
          color: Color(0xff13DF4C),
          boxShadow: [BoxShadow(color: Colors.black38, offset: Offset(0, 2))]),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: _searchController,
                maxLines: 1,
                onSubmitted: (value) {
                  BlocProvider.of<FilterBloc>(context).dispatch(FilterSetSearch(search: value));
                  _searchController.text="";
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
                      width: double.infinity,
                      color: Color(0xff0FC442),
                      child: Center(
                        child: Text(
                          "Rp. ${product.price}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
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
  const _ProductPageBody({Key key}) : super(key: key);

  Widget _buildFilterControl({BuildContext ctx, FilterInitialized filter}) {
    List<Map<String, dynamic>> _filterString = [];
    if ((filter.search ?? "") != "") {
      _filterString.add({
        "text": 'Nama "${filter.search}"',
        "tap": () {
          BlocProvider.of<FilterBloc>(ctx).dispatch(FilterSetSearch(search: ""));
        }
      });
    }
    if ((filter.category?.id ?? -1) > -1) {
      _filterString.add({
        "text": 'Category "${filter.category.name}"',
        "tap": () {
          BlocProvider.of<FilterBloc>(ctx).dispatch(FilterSetCategory(
              productCategory: filter.category, clearCategory: true));
        }
      });
    }

    if ((filter.star ?? 0) > 0) {
      _filterString.add({
        "text": 'Rating: ${filter.star} ke atas',
        "tap": () {
          BlocProvider.of<FilterBloc>(ctx).dispatch(FilterSetStar(star: 0));
        }
      });
    }

    if ((filter.minPrice ?? -1) >= 0) {
      if ((filter.maxPrice ?? -1) >= 0)
        _filterString.add({
          "text": 'Harga: antara ${filter.minPrice} sampai ${filter.maxPrice}',
          "tap": () {
            BlocProvider.of<FilterBloc>(ctx)
                .dispatch(FilterSetPrice(maxPrice: -1, minPrice: -1));
          }
        });
      else
        _filterString.add({
          "text": 'Harga: lebih dari ${filter.minPrice}',
          "tap": () {
            BlocProvider.of<FilterBloc>(ctx).dispatch(
                FilterSetPrice(maxPrice: filter.maxPrice, minPrice: -1));
          }
        });
    } else {
      if ((filter.maxPrice ?? -1) >= 0)
        _filterString.add({
          "text": 'Harga: kurang dari ${filter.maxPrice}',
          "tap": () {
            BlocProvider.of<FilterBloc>(ctx).dispatch(
                FilterSetPrice(maxPrice: -1, minPrice: filter.minPrice));
          }
        });
    }

    return _filterString.length == 0
        ? Container()
        : Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 2), blurRadius: 5)
            ], color: Colors.white),
            height: ScreenUtil().setHeight(30),
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
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    color: Color(0xff0FC442),
                  ),
                );
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(child: _Header(), height: ScreenUtil().setHeight(50)),
          BlocBuilder<FilterBloc, FilterState>(
              builder: (ctx, state) => (state is FilterInitialized)
                  ? _buildFilterControl(ctx: ctx, filter: state)
                  : Container()),
          BlocBuilder<ProductListBloc, ProductListState>(
            builder: (ctx, state) {
              if ((state is ProductListStatus) &&
                  (state.status == ProductListStatus.PRODUCT_LIST_FETCHING))
                return Container(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                );
              if (state is ProductListInitialized)
                return Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                        child: GridView.builder(
                          itemCount: state.length,
                          itemBuilder: (ctx, index) => _SlidingProductCard(
                            index: index,
                            product: state.product[index],
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3 / 5,
                                  mainAxisSpacing: ScreenUtil().setWidth(10),
                                  crossAxisSpacing: ScreenUtil().setWidth(10)),
                        )));
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductListBloc>(
      builder: (ctx) => ProductListBloc()..dispatch(ProductListInitialize()),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          child: new _ProductPageBody(),
        ),
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
