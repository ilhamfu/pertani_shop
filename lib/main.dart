import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/bloc/cart/bloc/bloc.dart';
import 'package:pertani_shop/bloc/cart/bloc/events.dart';
import 'package:pertani_shop/bloc/category/bloc/index.dart';
import 'package:pertani_shop/bloc/filter_bloc/index.dart';
import 'package:pertani_shop/pages/cart_page.dart';
import 'package:pertani_shop/pages/login_page.dart';
import 'package:pertani_shop/pages/main_page.dart';
import 'package:pertani_shop/pages/product_detail_page.dart';
import 'package:pertani_shop/pages/product_page.dart';
import 'package:pertani_shop/pages/register_page.dart';
import 'package:pertani_shop/pages/transaction_page.dart';
import 'package:pertani_shop/pages/user_page.dart';
import 'package:pertani_shop/utils/pertani_icon_icons.dart';
import 'package:pertani_shop/widgets/custom_scaffold.dart';
import 'package:pertani_shop/widgets/filter_drawer.dart';

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
      initialRoute: "/",
      routes: {
        "/": (ctx) => LandingPage(),
        "/detail": (ctx) => ProductDetailPage(),
        "/register": (ctx) => RegisterPage()
      },
    );
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool loggedIn = false;

  void login() {
    setState(() {
      loggedIn = true;
    });
  }

  void logout() {
    setState(() {
      loggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 360, height: 640, allowFontScaling: true)
          ..init(context);
    return loggedIn
        ? HomePage(
            logout: logout,
          )
        : LoginPage(login: login);
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.logout}) : super(key: key);
  final Function logout;
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 2;
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
    return MultiBlocProvider(
        providers: [
          BlocProvider<FilterBloc>(builder: (ctx)=>FilterBloc()),
          BlocProvider<CategoryBloc>(builder: (ctx)=>CategoryBloc()..dispatch(CategoryInitialize()),),
          BlocProvider<CartBloc>(builder: (ctx)=>CartBloc()..dispatch(CartFetch()),)
        ],
        child: CustomScaffold(
          endDrawer: _currentPage == 0 ? FilterDrawer() : null,
          bottomNavigationBar: _CustomBottomNavigationBar(
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
              UserPage(
                logout: widget.logout,
              ),
            ],
          ),
        ));
  }
}

class _CustomBottomNavigationBar extends StatelessWidget {
  const _CustomBottomNavigationBar(
      {Key key, this.currentIndex, this.changePage})
      : super(key: key);
  final int currentIndex;
  final Function changePage;
  @override
  Widget build(BuildContext context) {
    var buttonList = [
      {
        "label": "Produk",
        "icon": PertaniIcon.flour,
      },
      {
        "label": "Keranjang",
        "icon": PertaniIcon.shopping_cart,
      },
      {
        "label": "Beranda",
        "icon": PertaniIcon.icon,
      },
      {"label": "Transaksi", "icon": PertaniIcon.transaction},
      {"label": "User", "icon": PertaniIcon.users},
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
                color: active ? Colors.white : Color(0xff13DF4C),
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
                        size: ScreenUtil().setWidth(28),
                        
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            button["icon"],
                            color: Color(0xff13DF4C),
                            size: ScreenUtil().setWidth(20),
                          ),
                          Text(
                            button["label"],
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                                color: Color(0xff13DF4C),
                                fontWeight: FontWeight.bold,),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: 5,
              width: double.infinity,
              color: active ? Color(0xff13DF4C):Color(0xffC5EC3E) ,
            ),
          ],
        ));
  }
}
