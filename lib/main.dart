import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/bloc/cart/bloc_layer/index.dart';
import 'package:pertani_shop/bloc/product_category/bloc_layer/index.dart';
import 'package:pertani_shop/pages/cart_page.dart';
import 'package:pertani_shop/pages/login_page.dart';
import 'package:pertani_shop/pages/main_page.dart';
import 'package:pertani_shop/pages/product_detail_page.dart';
import 'package:pertani_shop/pages/product_page.dart';
import 'package:pertani_shop/pages/transaction_page.dart';
import 'package:pertani_shop/pages/user_page.dart';
import 'package:pertani_shop/widgets/custom_scaffold.dart';
import 'package:pertani_shop/widgets/filter_drawer.dart';

import 'bloc/filter/bloc_layer/index.dart';
import 'bloc/product/bloc_layer/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pertani Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: "/login",
      routes: {
        "/": (ctx) => HomePage(),
        "/login": (ctx) => LoginPage(),
        "/detail": (ctx) => ProductDetailPage()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 1;
  PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _changePage(int index) {
    setState(() {
      _currentPage = index;
      _pageController.jumpToPage(index);
    });
  }
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 360, height: 640, allowFontScaling: true)
          ..init(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
            builder: (ctx) => ProductBloc()..dispatch(FetchAllProduct()),
          ),
          BlocProvider<FilterBloc>(
            builder: (ctx) => FilterBloc(),
          ),
          BlocProvider<CartBloc>(
            builder: (ctx) => CartBloc()..dispatch(FetchCart()),
          ),
          BlocProvider<CategoryBloc>(
            builder: (ctx) => CategoryBloc()..dispatch(FetchCategory()),
          )
        ],
        child: CustomScaffold(
          endDrawer: _currentPage == 0 ? FilterDrawer() : null,
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: _currentPage,
            changePage: _changePage,
          ),
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              ProductPage(),
              CartPage(),
              MainPage(),
              TransactionPage(),
              UserPage(),
            ],
          ),
        ));
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key key, this.currentIndex, this.changePage})
      : super(key: key);
  final int currentIndex;
  final Function changePage;
  @override
  Widget build(BuildContext context) {
    var buttonList = [
      {
        "label": "Produk",
        "icon": Icons.shopping_cart,
      },
      {
        "label": "Keranjang",
        "icon": Icons.shopping_cart,
      },
      {
        "label": "Home",
        "icon": Icons.home,
      },
      {"label": "Transaksi", "icon": Icons.list},
      {"label": "User", "icon": Icons.person},
    ];
    return Container(
      height: kBottomNavigationBarHeight,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Row(
          children: buttonList
              .asMap()
              .map((index, button) => MapEntry(
                  index,
                  _CustomBNBButton(
                      active: index == currentIndex,
                      button: button,
                      buttonLength: buttonList.length,
                      onTap: () {
                        changePage(index);
                      })))
              .values
              .toList()),
    );
  }
}

class _CustomBNBButton extends StatelessWidget {
  const _CustomBNBButton({
    Key key,
    @required this.button,
    @required this.buttonLength,
    @required this.active,
    this.onTap,
  }) : super(key: key);
  final Map<String, dynamic> button;
  final int buttonLength;
  final bool active;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width / buttonLength;
    return Container(
        width: w,
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: double.infinity,
                width: double.infinity,
                color: active ? Colors.white : Colors.green,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: !active ? onTap : null,
                    child: Visibility(
                      visible: active,
                      replacement: Icon(
                        button["icon"],
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            button["icon"],
                            color: Colors.green,
                          ),
                          Text(button["label"],style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                )),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: 5,
              width: double.infinity,
              color: active ? Colors.green : Colors.orange,
            ),
          ],
        ));
  }
}
