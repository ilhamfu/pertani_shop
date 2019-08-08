import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/bloc/cart/bloc_layer/index.dart';
import 'package:pertani_shop/models/cart.dart';
import 'package:pertani_shop/widgets/add_cart_modal.dart';
import 'package:pertani_shop/widgets/clip_shadow_path.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(child: BlocBuilder<CartBloc, CartStates>(
            builder: (ctx, state) {
              if (state is CartFetching) {
                return CircularProgressIndicator();
              } else if (state is CartInitialized) {
                if (state.isEmpty)
                  return Text("Your Cart Is Empty");
                else
                  return ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (ctx, index) {
                      return CartItem(cart: state.carts[index]);
                    },
                  );
              } else
                return Text("Error while fetching cart");
            },
          )),
          Container(
            height: ScreenUtil().setHeight(30),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.green, blurRadius: 2)]),
            child: Stack(
              children: <Widget>[
                ClipShadowPath(
                  shadow: Shadow(
                      offset: Offset(1, -1),
                      color: Colors.black54,
                      blurRadius: 2),
                  clipper: _MClipper(),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.green),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Total",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(16)),
                          ),
                          BlocBuilder<CartBloc, CartStates>(
                            builder: (ctx, state) => Text(
                              (state is CartInitialized)
                                  ? "Rp. ${state.total}"
                                  : "Rp. 0",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize: ScreenUtil().setSp(16)),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  CartItem({Key key, this.cart}) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: ScreenUtil().setHeight(50),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      margin: EdgeInsets.all(ScreenUtil().setWidth(3)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: cart.active ? Colors.white : Colors.grey,
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                blurRadius: cart.active ? 10 : 0,
                offset: cart.active ? Offset(2, 2) : Offset(0, 0))
          ]),
      child: Row(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 250),
            margin: EdgeInsets.only(
                right: ScreenUtil().setWidth(!cart.active ? 5 : 3)),
            curve: Curves.easeIn,
            width: ScreenUtil().setWidth(!cart.active ? 40 : 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                color: cart.active ? Colors.green : Colors.red,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      offset: !cart.active ? Offset(3, 0) : Offset(0, 0),
                      blurRadius: 1)
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  BlocProvider.of<CartBloc>(context)
                      .dispatch(ToggleCart(cart: cart));
                },
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                int amount = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(5))),
                        builder: (ctx) => AddToCartWidget(
                              amount: cart.amount,
                              product: cart.product,
                            )) ??
                    0;
                if (amount > 0) {
                  BlocProvider.of<CartBloc>(context).dispatch(UpdateAmountCart(amount: amount,cart: cart));
                }
                // BlocProvider.of<CartBloc>(context).dispatch(AddCart());
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cart.product.name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: cart.active ? Colors.orange : Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(16)),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(20),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: ClipShadowPath(
                              child: Container(
                                  decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5)),
                                color: Colors.green,
                              )),
                              clipper: _MItemClipper(),
                              shadow: Shadow(
                                  blurRadius: 2,
                                  color: Colors.black54,
                                  offset: cart.active
                                      ? Offset(-2, -2)
                                      : Offset(0, 0)),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Total",
                                      style: TextStyle(
                                          color: cart.active
                                              ? Colors.orange
                                              : Colors.white54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(16))),
                                  Text("Rp. ${cart.total}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(16))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width, height = size.height;
    final path = new Path();
    path.lineTo(width * .2, 0);
    path.lineTo(width * .4, height);
    path.lineTo(width * .4, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class _MItemClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width, h = size.height;
    final path = new Path();
    path.moveTo(w * 0.5, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(w * .4, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
