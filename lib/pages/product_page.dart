import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/widgets/sliver_delegate.dart';

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

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class SlidingProductCard extends StatefulWidget {
  final int index;
  const SlidingProductCard({
    Key key,
    this.index,
  }) : super(key: key);
  @override
  _SlidingProductCardState createState() => _SlidingProductCardState();
}

class __FilterDrawerState extends State<_FilterDrawer> {
  List<Map<String, dynamic>> filterCategory;
  Map<String, dynamic> filterSetting;

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
                Container(
                  child: _buildFilterContainer(),
                  height: 515,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black)]),
                ),
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
                          widget.updateFilter(filterSetting);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    filterCategory = new List.from(widget.filterCategory);
    filterSetting = new Map.from(widget.filterSetting);
  }

  setCategoryFilter(Map<String, dynamic> cat) {
    setState(() {
      filterSetting["category"]["id"] == cat["id"]
          ? filterSetting["category"]["id"] = -1
          : filterSetting["category"] = new Map.from(cat);
    });
  }

  setStarFilter(int num) {
    setState(() {
      filterSetting["star"] = num == filterSetting["star"] ? 0 : num;
    });
  }

  setPriceFilter({int max: -1, int min: -1}) {
    if (max >= -1) {
      setState(() {
        filterSetting["price"]["max"] = max;
      });
    }
    if (min >= -1) {
      setState(() {
        filterSetting["price"]["min"] = min;
      });
    }
  }

  List<Widget> _buildCategoryFilterDrawer() {
    int filtered = filterSetting["category"]["id"];
    List<Widget> output = [];
    for (var item in filterCategory) {
      var inlist = filtered == item["id"];
      output.add(InkWell(
        onTap: () {
          setCategoryFilter(item);
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
          child: Text(item["name"],
              style: TextStyle(
                  color: !inlist ? Colors.white : Colors.green,
                  fontWeight: FontWeight.w600)),
        ),
      ));
    }
    return output;
  }

  Widget _buildFilterContainer() {
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
              Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  runSpacing: 3,
                  spacing: 3,
                  children: _buildCategoryFilterDrawer()),
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
                children: _buildStarFilter(),
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
              new _PriceRangeFilter(
                min: 0,
                max: 1000000,
                setPriceFilter: setPriceFilter,
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> _buildStarFilter() {
    int star = filterSetting["star"];
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
          setStarFilter(i);
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
                  maxLines: 1,
                  onSubmitted: (value) {
                    widget.setNameFilter(value);
                    _searchController.text = "";
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
  RangeValues currentValue;
  TextEditingController minTextController, maxTextController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
                  onSubmitted: (value) {
                    widget.setPriceFilter(min: value);
                  },
                  controller: minTextController,
                  maxLines: 1,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  decoration: InputDecoration(
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
                  onSubmitted: (value) {
                    widget.setPriceFilter(max: value);
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  controller: maxTextController,
                  maxLines: 1,
                  decoration: InputDecoration(
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
    // TODO: implement dispose
    minTextController.dispose();
    maxTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentValue = RangeValues(widget.min / 1000, widget.max / 1000);
    minTextController =
        new TextEditingController(text: widget.min.toInt().toString());
    maxTextController =
        new TextEditingController(text: widget.max.toInt().toString());
  }
}

class _FilterDrawer extends StatefulWidget {
  final Function updateFilter;

  final List<Map<String, dynamic>> filterCategory;
  final Map<String, dynamic> filterSetting;
  const _FilterDrawer({
    Key key,
    this.updateFilter,
    this.filterCategory,
    this.filterSetting,
  }) : super(key: key);

  @override
  __FilterDrawerState createState() => __FilterDrawerState();
}

class _Header extends StatefulWidget {
  final Function setNameFilter;

  const _Header({Key key, @required this.setNameFilter}) : super(key: key);

  @override
  __HeaderState createState() => __HeaderState();
}

class _PriceRangeFilter extends StatefulWidget {
  final double max;
  final double min;
  final Function setPriceFilter;
  const _PriceRangeFilter({
    Key key,
    @required this.max,
    @required this.min,
    @required this.setPriceFilter,
  }) : super(key: key);
  @override
  __PriceRangeFilterState createState() => __PriceRangeFilterState();
}

class _ProductCard extends StatelessWidget {
  final int index;

  const _ProductCard({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}

class _ProductPageBody extends StatelessWidget {
  final Map<String, dynamic> filterSetting;

  final Function setNameFilter;
  const _ProductPageBody(
      {Key key, @required this.filterSetting, @required this.setNameFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _filterString = [];

    if (filterSetting["name"] != "") {
      _filterString.add('Nama "${filterSetting["name"]}"');
    }

    if (filterSetting["category"]["id"] > -1) {
      _filterString.add('Category "${filterSetting["category"]["name"]}"');
    }

    if (filterSetting["star"] > 0) {
      _filterString.add('Rating: ${filterSetting["star"]} ke atas');
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
            floating: true,
            delegate: SliverAppBarDelegate(
                child: Container(
                  child: _Header(
                    setNameFilter: setNameFilter,
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black38)]),
                ),
                maxHeight: ScreenUtil().setHeight(50),
                minHeight: ScreenUtil().setHeight(50))),
        _filterString.length == 0
            ? SliverToBoxAdapter(
                child: Container(),
              )
            : SliverPersistentHeader(
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

class _ProductPageState extends State<ProductPage> {
  List<Map<String, dynamic>> filterCategory = [
    {"id": 1, "name": "Padi", "selected": false},
    {"id": 4, "name": "Beras", "selected": false},
    {"id": 8, "name": "Benih Padi", "selected": false},
    {"id": 12, "name": "Pupuk", "selected": false},
    {"id": 13, "name": "Obat Obatan", "selected": false},
    {"id": 14, "name": "Jagung", "selected": false},
    {"id": 15, "name": "Pupuk", "selected": false},
    {"id": 19, "name": "Obat Obatan", "selected": false},
    {"id": 20, "name": "Jagung", "selected": false},
    {"id": 22, "name": "Pupuk", "selected": false},
    {"id": 23, "name": "Obat Obatan", "selected": false},
    {"id": 25, "name": "Jagung", "selected": false},
    {"id": 28, "name": "Pupuk", "selected": false},
    {"id": 31, "name": "Obat Obatan", "selected": false},
    {"id": 33, "name": "Jagung", "selected": false}
  ];

  Map<String, dynamic> filterSetting = {
    "category": {"id": -1, "name": ""},
    "price": {
      "isActive": false,
      "max": 1000000,
      "min": 0,
    },
    "name": "",
    "star": 0
  };

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 360, height: 640, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      endDrawer: new _FilterDrawer(
          filterSetting: filterSetting,
          filterCategory: filterCategory,
          updateFilter: updateFilter),
      backgroundColor: Colors.green,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.white,
            child: new _ProductPageBody(
              filterSetting: filterSetting,
              setNameFilter: setSearchFilter,
            ),
          ),
        ),
      ),
    );
  }

  setSearchFilter(String value) {
    setState(() {
      filterSetting["name"] = value;
    });
  }

  updateFilter(Map<String, dynamic> data) {
    setState(() {
      filterSetting = new Map<String, dynamic>.from(data);
    });
  }
}

class _SlidingProductCardState extends State<SlidingProductCard> {
  double pos = 0;
  bool showed = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        print(context.size);
      },
      onHorizontalDragEnd: onDragEnd,
      onHorizontalDragUpdate: onDragUpdate,
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
}
