import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/bloc/filter_bloc/bloc.dart';
import 'package:pertani_shop/bloc/filter_bloc/index.dart';
import 'package:pertani_shop/models/product_category.dart';

class FilterDrawer extends StatefulWidget {
  FilterDrawer({Key key}) : super(key: key);

  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * .75,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              height: ScreenUtil().setHeight(45),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
              child: Center(
                child: Text(
                  "Filter",
                  style: TextStyle(
                      color: Color(0xff13DF4C),
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            BlocBuilder<FilterBloc, FilterState>(
              builder: (ctx, state) {
                print(state);
                if (state is FilterInitialized)
                  return Column(
                    children: <Widget>[
                      new _PriceFilter(price: {
                        "max": state.maxPrice,
                        "min": state.minPrice
                      }),
                      new _CategoryFilter(category: state.category),
                      new _StarFIlter(star: state.star),
                    ],
                  );
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}

class _PriceFilter extends StatelessWidget {
  const _PriceFilter({
    Key key,
    this.price,
  }) : super(key: key);

  final Map<String, dynamic> price;

  @override
  Widget build(BuildContext context) {
    print(price);
    return ExpansionTile(
      title: Text("Harga"),
      initiallyExpanded: true,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Minimum",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      ),
                      TextField(
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Maksimum",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _StarFIlter extends StatelessWidget {
  const _StarFIlter({
    Key key,
    this.star,
  }) : super(key: key);

  final int star;

  @override
  Widget build(BuildContext context) {
    print(star);
    return ExpansionTile(
      title: Text("Rating"),
      initiallyExpanded: true,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [1, 2, 3, 4, 5]
                .map((e) => Container(
                      decoration: BoxDecoration(
                          color: star == e ? Color(0xff13DF4C) : Colors.white,
                          border:
                              Border.all(color: Color(0xff13DF4C), width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.all(2),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<FilterBloc>(context).dispatch(
                                FilterSetStar(star: e == star ? 0 : e));
                          },
                          splashColor: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children:
                                  ((int value, bool selected) => [1, 2, 3, 4, 5]
                                      .map((e2) => e2 <= value)
                                      .map((e3) => Icon(
                                            e3 ? Icons.star : Icons.star_border,
                                            color: selected
                                                ? Colors.white
                                                : Color(0xff13DF4C),
                                            size: ScreenUtil().setWidth(15),
                                          ))
                                      .toList())(e, star == e),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter({
    Key key,
    this.category,
  }) : super(key: key);

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Kategori"),
      initiallyExpanded: true,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Wrap(
            children: [
              new ProductCategory(id: 0, name: "Padi"),
              new ProductCategory(id: 1, name: "Jagung"),
              new ProductCategory(id: 2, name: "Kentang"),
              new ProductCategory(id: 3, name: "Beras"),
              new ProductCategory(id: 4, name: "Wortel"),
            ]
                .map((element) => Container(
                      decoration: BoxDecoration(
                          color: category == element
                              ? Colors.white
                              : Color(0xff13DF4C),
                          border:
                              Border.all(color: Color(0xff13DF4C), width: 3),
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.all(2),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<FilterBloc>(context).dispatch(
                                FilterSetCategory(
                                    productCategory:
                                        element,
                                    clearCategory: category == element));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 6),
                            child: Text(
                              element.name,
                              style: TextStyle(
                                  color: category != element
                                      ? Colors.white
                                      : Color(0xff13DF4C),
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
