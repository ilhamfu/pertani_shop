import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/bloc/filter/bloc_layer/index.dart';
import 'package:pertani_shop/bloc/product_category/bloc_layer/index.dart';
import 'package:pertani_shop/models/product_category.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({
    Key key,
  }) : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class __PriceRangeFilterState extends State<_PriceRangeFilter> {
  TextEditingController minTextController, maxTextController;
  FocusNode minTextNode = FocusNode(), maxTextNode = FocusNode();

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

class _FilterDrawerState extends State<FilterDrawer> {
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
                    return _FilterContainer(filter: state.toMap());
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

class _FilterContainer extends StatelessWidget {
  const _FilterContainer({Key key, @required this.filter}) : super(key: key);
  final Map<String, dynamic> filter;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(4),
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black)]),
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
                    return _CategoryFilter(
                      categoryList: state.category,
                      category: filter["category"],
                    );
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
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black)]),
            child: Column(
              children: <Widget>[
                SizedBox(height: ScreenUtil().setHeight(10)),
                Text("Penilaian",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        color: Colors.green,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: ScreenUtil().setHeight(20)),
                _StarFilter(
                  star: filter["star"],
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
      ),
      height: 515,
      decoration: BoxDecoration(
          color: Colors.white, boxShadow: [BoxShadow(color: Colors.black)]),
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter(
      {Key key, @required this.category, @required this.categoryList})
      : super(key: key);
  final ProductCategory category;
  final List<ProductCategory> categoryList;
  @override
  Widget build(BuildContext context) {
    return Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        verticalDirection: VerticalDirection.down,
        runSpacing: 3,
        spacing: 3,
        children: categoryList
            .map((e) => InkWell(
                  onTap: () {
                    if (e != category)
                      BlocProvider.of<FilterBloc>(context).dispatch(
                          UpdateCategory(category: e, removeCategory: false));
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
                      color: e == category ? Colors.white : Colors.green,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(2),
                      horizontal: ScreenUtil().setWidth(8),
                    ),
                    child: Text(e.name,
                        style: TextStyle(
                            color: e != category ? Colors.white : Colors.green,
                            fontWeight: FontWeight.w600)),
                  ),
                ))
            .toList());
  }
}

class _StarFilter extends StatelessWidget {
  const _StarFilter({Key key, @required this.star}) : super(key: key);
  final int star;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      verticalDirection: VerticalDirection.down,
      runSpacing: ScreenUtil().setWidth(10),
      spacing: ScreenUtil().setWidth(10),
      children: [1, 2, 3, 4, 5]
          .map((e) => InkWell(
                onTap: () {
                  BlocProvider.of<FilterBloc>(context)
                      .dispatch(UpdateStar(star: e));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(2),
                    horizontal: ScreenUtil().setWidth(4),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: e != star ? Colors.white : Colors.orange,
                      border: Border.all(color: Colors.orange, width: 2)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [1, 2, 3, 4, 5]
                        .map((ie) => Icon(
                              ie <= e ? Icons.star : Icons.star_border,
                              size: ScreenUtil().setWidth(15),
                              color: e == star ? Colors.white : Colors.orange,
                            ))
                        .toList(),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
