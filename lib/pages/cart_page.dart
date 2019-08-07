import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/widgets/clip_shadow_path.dart';
import 'package:pertani_shop/widgets/custom_bottom.dart';
import 'package:pertani_shop/widgets/custom_scaffold.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                      height: 10,
                      color: Colors.yellow,
                      margin: EdgeInsets.all(2));
                },
              ),
            )),
            Container(
              height: ScreenUtil().setHeight(30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.green,blurRadius: 2)]),
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
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
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
                        Text("Rp. 20000",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(16)),)
                      ],
                    )),
                  )
                ],
              ),
            )
          ],
        ),
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
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
