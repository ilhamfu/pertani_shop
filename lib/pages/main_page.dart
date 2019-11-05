import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/utils/pertani_icon_icons.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new _CustomAppBar(),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(30),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 5,
                            offset: Offset(0, 5))
                      ]),
                  height: ScreenUtil().setWidth(80),
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (ctx, index) => _ProductItem(
                          index: index,
                        ),
                    childCount: 100),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2),
              )
            ],
          ),
        )),
      ],
    );
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(color: Colors.black54, blurRadius: 5, offset: Offset(5, 5))
      ]),
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: "https://picsum.photos/id/$index/300/400",
                placeholder: (ctx, str) =>
                    Image.asset("assets/product_placeholder.png"),
                errorWidget: (ctx, str, err) =>
                    Image.asset("assets/product_placeholder.png"),
              )),
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      height: 25,
                      child: Center(
                          child: Text("Rp. 20000",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.bold))),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.75),
                      )),
                  Text(
                    "Nama Produk $index",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(15)),
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

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(50),
      decoration: BoxDecoration(
          color: Color(0xff13DF4C),
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextField(
                style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Cari Produk",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.all(0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
          ),
          _buildButton(),
        ],
      ),
    );
  }

  Row _buildButton() {
    return Row(children: <Widget>[
      Container(
        decoration: BoxDecoration(color: Color(0xff0FC442), boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0x0f, 0xc4, 0x42, 0.5),
              blurRadius: 2,
              offset: Offset(0, -5))
        ]),
        width: 2,
      ),
      Container(
        width: ScreenUtil().setWidth(50),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.white,
                onTap: () {},
                child: Icon(
                  PertaniIcon.chat,
                  color: Colors.white,
                  size: ScreenUtil().setWidth(30),
                ))),
      ),
      Container(
        decoration: BoxDecoration(color: Color(0xff0FC442), boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0x0f, 0xc4, 0x42, 0.5),
              blurRadius: 2,
              offset: Offset(0, -5))
        ]),
        width: 2,
      ),
      Container(
        width: ScreenUtil().setWidth(50),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white,
            onTap: () {},
            child: Icon(
              Icons.notifications,
              color: Colors.white,
              size: ScreenUtil().setWidth(30),
            ),
          ),
        ),
      ),
    ]);
  }
}
