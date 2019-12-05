import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/models/product.dart';
import 'package:pertani_shop/widgets/add_cart_modal.dart';
import 'package:pertani_shop/widgets/sliver_delegate.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key key}) : super(key: key);

  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: _ProductDetailBody(product: product),
      )),
    );
  }
}

class _ProductDetailBody extends StatefulWidget {
  const _ProductDetailBody({Key key, this.product}) : super(key: key);
  final Product product;
  @override
  __ProductDetailBodyState createState() => __ProductDetailBodyState();
}

class __ProductDetailBodyState extends State<_ProductDetailBody> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: CustomSliverDelegate(
            maxHeight: ScreenUtil().setHeight(50),
            minHeight: ScreenUtil().setHeight(50),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF13DF4C),
                  boxShadow: [
                    BoxShadow(color: Colors.black38, blurRadius: 3),
                  ],
                  border: Border(
                    bottom: BorderSide(
                        color: Color(0xFF13DF4C),
                        width: ScreenUtil().setWidth(2)),
                  )),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Hero(
            tag: widget.product.id,
            child: Container(
              height: ScreenUtil().setHeight(360 / 4 * 3),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  PageView.builder(
                    controller: _pageController,
                    itemCount: widget.product.productImages.length,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: widget.product.productImages[index],
                      );
                    },
                  ),
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 35),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildIndicator(
                              length: widget.product.productImages.length),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: CustomSliverDelegate(
              maxHeight: ScreenUtil().setHeight(50),
              minHeight: ScreenUtil().setHeight(50),
              child: _buildHeader(name: widget.product.name)),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: ScreenUtil().setHeight(80),
            child: Center(
              child: Table(
                columnWidths: {
                  0: FixedColumnWidth(ScreenUtil().setWidth(60)),
                  1: FixedColumnWidth(ScreenUtil().setWidth(10)),
                  2: FixedColumnWidth(ScreenUtil().setWidth(200)),
                },
                children: [
                  TableRow(children: [
                    Text(
                      "Harga",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w700),
                    ),
                    Container(),
                    Text("Rp. ${widget.product.price}",
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.w700)),
                  ]),
                  TableRow(children: [
                    Text(
                      "Tersedia",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w700),
                    ),
                    Container(),
                    Text("${widget.product.stock}",
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.w700)),
                  ]),
                  TableRow(children: [
                    Text(
                      "Kategori",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w700),
                    ),
                    Container(),
                    Text(
                      "${widget.product.productCategory.name}",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.w700),
                    ),
                  ])
                ],
              ),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: CustomSliverDelegate(
              maxHeight: ScreenUtil().setHeight(50),
              minHeight: ScreenUtil().setHeight(50),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
                decoration: BoxDecoration(
                    color: Color(0xFF13DF4C),
                    boxShadow: [
                      BoxShadow(color: Color(0xFF13DF4C), blurRadius: 3),
                    ],
                    border: Border(
                      top: BorderSide(
                          color: Color(0xFF13DF4C), width: ScreenUtil().setWidth(2)),
                      bottom: BorderSide(
                          color: Color(0xFF13DF4C), width: ScreenUtil().setWidth(2)),
                    )),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Deskripsi",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(15)),
                  ),
                ),
              )),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
            constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(400)),
            child: Text(
              widget.product.desc,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: CustomSliverDelegate(
              maxHeight: ScreenUtil().setHeight(40),
              minHeight: ScreenUtil().setHeight(40),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
                decoration: BoxDecoration(
                    color: Color(0xFF13DF4C),
                    boxShadow: [
                      BoxShadow(color: Colors.white, blurRadius: 3),
                    ],
                    border: Border(
                      top: BorderSide(
                          color: Color(0xFF13DF4C), width: ScreenUtil().setWidth(2)),
                      bottom: BorderSide(
                          color: Color(0xFF13DF4C), width: ScreenUtil().setWidth(2)),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Testimoni",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(15)),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          widget.product.avgRate.toStringAsPrecision(1),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(15)),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: ScreenUtil().setWidth(17),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((ctx, index) {
            return Container(
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(5)),
              padding: EdgeInsets.all(ScreenUtil().setWidth(2)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.orange,
                              width: ScreenUtil().setWidth(2)),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "https://picsum.photos/id/1/300/400")))),
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(280),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.grey,
                            width: ScreenUtil().setWidth(1)),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(2, 2))
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.orange,
                                      width: ScreenUtil().setSp(2)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Username",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w700,
                                    fontSize: ScreenUtil().setSp(15)),
                              ),
                              _buildStar(
                                  size: ScreenUtil().setWidth(10),
                                  color: Colors.orange,
                                  rating: 5)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                          child: Text(
                            "testString",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }, childCount: 5),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              margin:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
              height: ScreenUtil().setHeight(40),
              width: ScreenUtil().setWidth(200),
              child: Material(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {},
                  splashColor: Colors.white,
                  child: Center(
                      child: Text(
                    "Testimoni Lain..",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(17)),
                  )),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildIndicator({int length}) {
    List<Widget> data = [];
    for (int i = 0; i < length; i++) {
      data.add(
        AnimatedContainer(
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.symmetric(horizontal: 3),
          height: ScreenUtil().setHeight(3),
          width: ScreenUtil().setWidth(17),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _currentPage == i ? Colors.green : Colors.white,
              boxShadow: [
                BoxShadow(
                    color: _currentPage == i ? Colors.white : Colors.green,
                    blurRadius: 1,
                    offset: _currentPage != i ? Offset(0, 2) : Offset(0, 0))
              ]),
        ),
      );
    }
    return data;
  }

  Container _buildStar({double size, Color color, double rating}) {
    List<Widget> star = [];

    for (var i = 1; i <= 5; i++) {
      star.add(Icon(
        i <= rating ? Icons.star : Icons.star_border,
        size: size,
        color: color,
      ));
    }

    return Container(
      child: Row(children: star),
    );
  }

  Container _buildHeader({@required String name}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
      decoration: BoxDecoration(
          color: Color(0xFF13DF4C),
          boxShadow: [
            BoxShadow(color: Color(0xFF13DF4C), blurRadius: 3),
          ],
          border: Border(
              top: BorderSide(
                  color: Color(0xFF13DF4C), width: ScreenUtil().setWidth(2)),
              bottom: BorderSide(
                  color: Color(0xFF13DF4C), width: ScreenUtil().setWidth(2)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: ScreenUtil().setSp(15)),
          ),
          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(30),
                height: ScreenUtil().setWidth(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Colors.white, width: ScreenUtil().setWidth(2))),
                child: Material(
                  color: Color(0xFF13DF4C),
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.white,
                    child: Icon(
                      Icons.chat,
                      size: ScreenUtil().setWidth(20),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(10),
              ),
              Container(
                width: ScreenUtil().setWidth(30),
                height: ScreenUtil().setWidth(30),
                decoration: BoxDecoration(
                    color: Color(0xFF13DF4C),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Colors.white, width: ScreenUtil().setWidth(2))),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          builder: (ctx) {
                            return AddToCartWidget(
                              product: widget.product,
                            );
                          },
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10))));
                    },
                    splashColor: Colors.white,
                    child: Icon(
                      Icons.add_shopping_cart,
                      size: ScreenUtil().setWidth(20),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
