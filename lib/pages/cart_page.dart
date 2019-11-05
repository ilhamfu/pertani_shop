import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/bloc/cart/bloc/index.dart';
import 'package:pertani_shop/models/cart.dart';
import 'package:pertani_shop/widgets/custom_dialog.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Color(0xff13DF4C),
                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
            height: ScreenUtil().setWidth(50),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    "Keranjang",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(20),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    height: ScreenUtil().setWidth(50),
                    width: ScreenUtil().setWidth(50),
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.grey, width: 2))),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(builder: (ctx, state) {
              if ((state is CartStatus) &&
                  state.status == CartStatus.CART_FETCHING)
                return Container(
                  child: CircularProgressIndicator(),
                );

              if (state is CartInitialized)
                return ListView.separated(
                  padding:
                      EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                  separatorBuilder: (_, __) => SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  itemCount: state.length,
                  itemBuilder: (ctx, index) {
                    return new _CartItem(
                      cart: state.carts[index],
                    );
                  },
                );
              return Container();
            }),
          )
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (_) async {
        return await showDialog(
                context: context,
                barrierDismissible: true,
                builder: (txt) => CustomYesNoDialog(
                      title: "Hapus Data Keranjang",
                      yesButtonText: "Hapus dari Keranjang",
                      description:
                          "Anda akan menghapus ${cart.product.name} dari keranjang?",
                      noButtonText: "Batal",
                    )) ??
            false;
      },
      direction: DismissDirection.endToStart,
      key: Key("${cart.id}"),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        height: ScreenUtil().setWidth(100),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 5, offset: Offset(0, 2))
        ]),
        child: Row(
          children: <Widget>[
            Container(
              color: cart.active ? Color(0xff13DF4C) : Color(0xff301530),
              width: ScreenUtil().setWidth(30),
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 3 / 4,
                    child: CachedNetworkImage(
                      imageUrl: cart.product.imageList[0],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${cart.product.name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(15)),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Jumlah : ${cart.amount}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Harga : Rp.${cart.product.price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: ScreenUtil().setHeight(30),
                          color: Color(0xff13DF4C),
                          child: Center(
                            child: Text(
                              "Rp. ${cart.total}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
