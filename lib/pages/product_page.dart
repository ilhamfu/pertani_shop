import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pertani_shop/bloc/filter/bloc_layer/index.dart';
import 'package:pertani_shop/bloc/product_category/bloc_layer/index.dart';
import 'package:pertani_shop/main.dart';
import 'package:pertani_shop/models/product.dart';
import 'package:pertani_shop/models/product_category.dart';
import 'package:pertani_shop/pages/product_detail_page.dart';
import 'package:pertani_shop/utils/filter.dart';
import 'package:pertani_shop/widgets/sliver_delegate.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class SlidingProductCard extends StatefulWidget {
  final int index;
  final Product product;
  const SlidingProductCard({Key key, this.index, this.product})
      : super(key: key);
  @override
  _SlidingProductCardState createState() => _SlidingProductCardState();
}

class __FilterDrawerState extends State<_FilterDrawer> {
  var filterStream = getIt<FilterStream>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.green,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
                  if (state is FilterSet) {
                    return Container(
                      child: _buildFilterContainer(filter: state.toMap()),
                      height: 515,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black)]),
                    );
                  }
                  return Container(
                      height: 515,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black)]));
                }),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black)]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Simpan Perubahan",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(15),
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                        color: Colors.green,
                      ),
                      RaisedButton(
                          onPressed: () {},
                          child: Text("Atur Ulang",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(15),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
                          color: Colors.red)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCategoryFilterDrawer(
      List<ProductCategory> data, ProductCategory categoryFilter) {
    int filtered = (categoryFilter?.id) ?? -1;
    List<Widget> output = [];
    for (var item in data) {
      var inlist = filtered == item.id;
      output.add(InkWell(
        onTap: () {
          if (!inlist)
            BlocProvider.of<FilterBloc>(context).dispatch(
                UpdateCategory(category: item, removeCategory: false));
          else
            BlocProvider.of<FilterBloc>(context)
                .dispatch(UpdateCategory(removeCategory: true));
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Colors.green, width: ScreenUtil().setWidth(2)),
            color: inlist ? Colors.white : Colors.green,
          ),
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(2),
            horizontal: ScreenUtil().setWidth(8),
          ),
          child: Text(item.name,
              style: TextStyle(
                  color: !inlist ? Colors.white : Colors.green,
                  fontWeight: FontWeight.w600)),
        ),
      ));
    }

    return output;
  }

  Widget _buildFilterContainer({Map<String, dynamic> filter}) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(4),
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white, boxShadow: [BoxShadow(color: Colors.black)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(10)),
              Text("Kategori",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.green,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: ScreenUtil().setHeight(10)),
              BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                if (state is CategoryInitialized) {
                  return Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      verticalDirection: VerticalDirection.down,
                      runSpacing: 3,
                      spacing: 3,
                      children: _buildCategoryFilterDrawer(
                          state.category, filter["category"]));
                } else
                  return Container();
              }),
              SizedBox(height: ScreenUtil().setHeight(10)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 1),
          padding: EdgeInsets.all(4),
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white, boxShadow: [BoxShadow(color: Colors.black)]),
          child: Column(
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(10)),
              Text("Penilaian",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.green,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                verticalDirection: VerticalDirection.down,
                runSpacing: ScreenUtil().setWidth(10),
                spacing: ScreenUtil().setWidth(10),
                children: _buildStarFilter(star: filter["star"]),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(20)),
              Text("Harga",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.green,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: ScreenUtil().setHeight(20)),
              _PriceRangeFilter(
                min: filter["price"]["min"],
                max: filter["price"]["max"],
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> _buildStarFilter({int star}) {
    List<Widget> output = [];
    for (int i = 1; i <= 5; i++) {
      List<Widget> inner = [];
      for (int j = 1; j <= 5; j++) {
        inner.add(Icon(
          j <= i ? Icons.star : Icons.star_border,
          size: ScreenUtil().setWidth(15),
          color: i == star ? Colors.white : Colors.orange,
        ));
      }
      output.add(InkWell(
        onTap: () {
          if (i != star)
            BlocProvider.of<FilterBloc>(context).dispatch(UpdateStar(star: i));
          else
            BlocProvider.of<FilterBloc>(context).dispatch(UpdateStar(star: 0));
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(2),
            horizontal: ScreenUtil().setWidth(4),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: i != star ? Colors.white : Colors.orange,
              border: Border.all(color: Colors.orange, width: 2)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: inner,
          ),
        ),
      ));
    }
    return output;
  }
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
                    BlocProvider.of<FilterBloc>(context).dispatch(UpdateSearch(term:value));
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

class __PriceRangeFilterState extends State<_PriceRangeFilter> {
  TextEditingController minTextController, maxTextController;
  FocusNode minTextNode, maxTextNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
                  onEditingComplete: () {
                    _setPriceFilter();
                    minTextNode.unfocus();
                  },
                  focusNode: minTextNode,
                  controller: minTextController,
                  maxLines: 1,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  decoration: InputDecoration(
                      hintText: "Min",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(5),
                          vertical: ScreenUtil().setHeight(10))))),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
            color: Colors.green,
            height: ScreenUtil().setHeight(2),
            width: ScreenUtil().setWidth(15),
          ),
          Expanded(
              child: TextField(
                  focusNode: maxTextNode,
                  onEditingComplete: () {
                    _setPriceFilter();
                    maxTextNode.unfocus();
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  controller: maxTextController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      hintText: "Max",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(5),
                          vertical: ScreenUtil().setHeight(10))))),
        ],
      ),
    );
  }

  @override
  void dispose() {
    minTextController.dispose();
    maxTextController.dispose();
    maxTextNode.dispose();
    minTextNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    maxTextNode = new FocusNode();
    minTextNode = new FocusNode();
    minTextController = new TextEditingController(
        text: widget.min > -1 ? widget.min.toString() : "");
    maxTextController = new TextEditingController(
        text: widget.max > -1 ? widget.max.toString() : "");
    maxTextNode.addListener(() {
      if (!maxTextNode.hasFocus) _setPriceFilter();
    });
    minTextNode.addListener(() {
      if (!minTextNode.hasFocus) _setPriceFilter();
    });
  }

  _setPriceFilter() {
    BlocProvider.of<FilterBloc>(context).dispatch(UpdatePrice(
        max: maxTextController.text != ""
            ? int.parse(maxTextController.text)
            : -1,
        min: minTextController.text != ""
            ? int.parse(minTextController.text)
            : -1));
  }
}

class _FilterDrawer extends StatefulWidget {
  const _FilterDrawer({
    Key key,
  }) : super(key: key);

  @override
  __FilterDrawerState createState() => __FilterDrawerState();
}

class _Header extends StatefulWidget {
  const _Header({Key key}) : super(key: key);

  @override
  __HeaderState createState() => __HeaderState();
}

class _PriceRangeFilter extends StatefulWidget {
  final int max, min;
  const _PriceRangeFilter({
    Key key,
    @required this.max,
    @required this.min,
  }) : super(key: key);
  @override
  __PriceRangeFilterState createState() => __PriceRangeFilterState();
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
        Navigator.of(context).push(
          CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) {
                return ProductDetailPage();
              }),
        );
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
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
        BlocBuilder<FilterBloc, FilterState>(
            //buildCategory
            builder: (context, state) {
          if (state is FilterSet)
            return _buildFilterControl(context: context, filter: state.toMap());
          return SliverToBoxAdapter(child: Container());
        }),
        SliverPadding(
          padding: const EdgeInsets.all(2.0),
          sliver: StreamBuilder(
              //buildProduct
              stream: null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Container(
                        child: Center(child: CircularProgressIndicator())),
                  );
                } else {
                  if ((snapshot.hasData)) {
                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate((ctx, index) {
                        return SlidingProductCard(
                            index: index, product: snapshot.data[index]);
                      }, childCount: snapshot.data.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3 / 4,
                          crossAxisCount: 2,
                          crossAxisSpacing: ScreenUtil().setWidth(5),
                          mainAxisSpacing: ScreenUtil().setWidth(5)),
                    );
                  } else {
                    if (snapshot.hasError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) =>
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("Error Cuy"))));
                    }
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
                  }
                }
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
    ScreenUtil.instance =
        ScreenUtil(width: 360, height: 640, allowFontScaling: true)
          ..init(context);
    return BlocProvider(
      builder: (ctx) => FilterBloc(),
      child: BlocProvider(
        builder: (ctx) => CategoryBloc()..dispatch(FetchCategory()),
        child: Scaffold(
          endDrawer: new _FilterDrawer(),
          backgroundColor: Colors.green,
          floatingActionButton: FloatingActionButton(onPressed: () {}),
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
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class _SlidingProductCardState extends State<SlidingProductCard> {
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
          child: _ProductCard(index: widget.index, product: widget.product),
          actionPane: SlidableBehindActionPane(),
          actions: widget.index % 2 != 0
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
          secondaryActions: widget.index % 2 == 0
              ? <Widget>[
                  IconSlideAction(
                    color: Colors.green,
                    icon: Icons.add_shopping_cart,
                    onTap: () {},
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
