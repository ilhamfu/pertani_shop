import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/widgets/sliver_delegate.dart';

var testString = ("Pelaksanaan kerja praktik berlangsung di SMAN 2 Tulang Bawang Tengah di Bagian Tata Usaha. Penulis juga ikut membantu dibagian operator sekolah. Dalam pelaksanaan pekerjaan di admin sekolahan kesulitan yang di hadapi adalah proses pendataan biodata yang masih di lakukan secara manual sehingga setiap kali memmbutuhan bio data selalu mengulangi proses manual tersebut. Hal itu menyebabkan lamanya proses pengumpulan data dan belum lagi sulitnya menemui yang bio datanya di butuhkan." +
    "Oleh karena itu penulis mengusulkan sebuah sistem informasi data guru berbasis web di SMA N 2 Tulang Bawang Tengah. Dimana sistem tersebut dapat melakukan pendataan guru dan dengan di buatnya sistem informasi data guru berbasis web ini di harapkan dapat membantu guru lain untuk mendapatkan biodata guru yang di butuhkan."
        "\nPelaksanaan kerja praktik berlangsung di SMAN 2 Tulang Bawang Tengah di Bagian Tata Usaha. Penulis juga ikut membantu dibagian operator sekolah. Dalam pelaksanaan pekerjaan di admin sekolahan kesulitan yang di hadapi adalah proses pendataan biodata yang masih di lakukan secara manual sehingga setiap kali memmbutuhan bio data selalu mengulangi proses manual tersebut. Hal itu menyebabkan lamanya proses pengumpulan data dan belum lagi sulitnya menemui yang bio datanya di butuhkan." +
    "Oleh karena itu penulis mengusulkan sebuah sistem informasi data guru berbasis web di SMA N 2 Tulang Bawang Tengah. Dimana sistem tersebut dapat melakukan pendataan guru dan dengan di buatnya sistem informasi data guru berbasis web ini di harapkan dapat membantu guru lain untuk mendapatkan biodata guru yang di butuhkan."
        "\nPelaksanaan kerja praktik berlangsung di SMAN 2 Tulang Bawang Tengah di Bagian Tata Usaha. Penulis juga ikut membantu dibagian operator sekolah. Dalam pelaksanaan pekerjaan di admin sekolahan kesulitan yang di hadapi adalah proses pendataan biodata yang masih di lakukan secara manual sehingga setiap kali memmbutuhan bio data selalu mengulangi proses manual tersebut. Hal itu menyebabkan lamanya proses pengumpulan data dan belum lagi sulitnya menemui yang bio datanya di butuhkan." +
    "Oleh karena itu penulis mengusulkan sebuah sistem informasi data guru berbasis web di SMA N 2 Tulang Bawang Tengah. Dimana sistem tersebut dapat melakukan pendataan guru dan dengan di buatnya sistem informasi data guru berbasis web ini di harapkan dapat membantu guru lain untuk mendapatkan biodata guru yang di butuhkan.");

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key key}) : super(key: key);

  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: _ProductDetailBody(),
      )),
    );
  }
}

class _ProductDetailBody extends StatelessWidget {
  const _ProductDetailBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: CustomSliverDelegate(
            maxHeight: ScreenUtil().setHeight(30),
            minHeight: ScreenUtil().setHeight(30),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black, blurRadius: 3),
                  ],
                  border: Border(
                    bottom: BorderSide(color: Colors.green, width: 2),
                  )),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: ScreenUtil().setHeight(200),
            decoration: BoxDecoration(
              color: Colors.black26,
            ),
            child: PageView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: "https://picsum.photos/id/${index % 10}/300/400",
                );
              },
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: CustomSliverDelegate(
              maxHeight: ScreenUtil().setHeight(40),
              minHeight: ScreenUtil().setHeight(40),
              child: _buildHeader()),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
            constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(400)),
            child: Text(
              testString,
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
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black, blurRadius: 3),
                    ],
                    border: Border(
                      top: BorderSide(
                          color: Colors.green, width: ScreenUtil().setWidth(2)),
                      bottom: BorderSide(
                          color: Colors.green, width: ScreenUtil().setWidth(2)),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Testimoni",
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(15)),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "5.0",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(15)),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
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
                            testString,
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
                        color: Colors.white, fontWeight: FontWeight.w700,fontSize: ScreenUtil().setSp(17)),
                  )),
                ),
              ),
            ),
          ),
        )
      ],
    );
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

  Container _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 3),
          ],
          border: Border(
              top: BorderSide(
                  color: Colors.green, width: ScreenUtil().setWidth(2)),
              bottom: BorderSide(
                  color: Colors.green, width: ScreenUtil().setWidth(2)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "NAMA PRODUCT NYA",
            style: TextStyle(
                color: Colors.orange,
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
                        color: Colors.orange, width: ScreenUtil().setWidth(2))),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.orange,
                    child: Icon(
                      Icons.chat,
                      size: ScreenUtil().setWidth(20),
                      color: Colors.orange,
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
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Colors.orange, width: ScreenUtil().setWidth(2))),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.orange,
                    child: Icon(
                      Icons.add_shopping_cart,
                      size: ScreenUtil().setWidth(20),
                      color: Colors.orange,
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
