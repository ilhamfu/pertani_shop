import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/widgets/custom_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({Key key}) : super(key: key);

  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final pages = [
    {"label": "Perlu Konfirmasi", "icon": Icons.event_note},
    {"label": "Dalam Proses", "icon": Icons.directions_run},
    {"label": "Selesai", "icon": Icons.call_end},
    {"label": "Dibatalkan", "icon": Icons.cancel}
  ];
  PageController controller = PageController(initialPage: 0);
  int currentPage = 0;

  _changePage(int page) {
    setState(() {
      currentPage = page;
      controller.jumpToPage(currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          new _CustomNavigator(
              pages: pages, currentPage: currentPage, changePage: _changePage),
          Expanded(
            child: PageView(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                _TransactionNotProcess(),
                _TransactionOnProcess(),
                _TransactionFinished(),
                _TransactionCanceled()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TransactionOnProcess extends StatelessWidget {
  const _TransactionOnProcess({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        _buildDetail(),
        _buildHistory(context: context),
        _buildProductList()
      ]),
    );
  }

  _buildHistory({BuildContext context}) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black38, offset: Offset(2, 2), blurRadius: 2)
      ], borderRadius: BorderRadius.circular(5), color: Colors.white),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(4),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(4),
          vertical: ScreenUtil().setHeight(4)),
      child: ExpansionTile(
        title: Text(
          "Status Transaksi",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          Column(
            children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
                .map((_) => new _TransactionHistoryitem())
                .toList(),
          )
        ],
      ),
    );
  }

  Container _buildDetail() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 3, offset: Offset(2, 2))
          ],
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(15),
          vertical: ScreenUtil().setWidth(5)),
      height: ScreenUtil().setHeight(180),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Tanggal Pembelian",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    Text(
                        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 1,
                      width: ScreenUtil().setWidth(130),
                      child: Material(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Status",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    Text("Diproses",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 1,
                      width: ScreenUtil().setWidth(130),
                      child: Material(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Kode Transaksi",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text("7c3c7b7f-1458-4e39-9336-3681c246be8e",
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 1,
                width: ScreenUtil().setWidth(300),
                child: Material(
                  color: Colors.grey,
                ),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Total",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text("Rp. 200000",
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 1,
                width: ScreenUtil().setWidth(300),
                child: Material(
                  color: Colors.grey,
                ),
              )),
        ],
      ),
    );
  }

  _buildProductList() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black38, offset: Offset(2, 2), blurRadius: 2)
      ], borderRadius: BorderRadius.circular(5), color: Colors.white),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(4),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(4),
      ),
      child: ExpansionTile(
        title: Text(
          "Daftar barang ",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          Column(
            children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
                .map((_) => _TrasactionProductItem())
                .toList(),
          )
        ],
      ),
    );
  }

  Future _buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: QrImage(
                      version: 3,
                      data: "7c3c7b7f-1458-4e39-9336-3681c246be8e",
                      size: 280,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
                width: 280,
                height: 280,
              ),
            ));
  }
}

class _TransactionHistoryitem extends StatelessWidget {
  const _TransactionHistoryitem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(3),horizontal: ScreenUtil().setWidth(3)),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black38, blurRadius: 3, offset: Offset(2, 2))
      ], color: Colors.white, borderRadius: BorderRadius.circular(3)),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: _MHistoryClipper(),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(3)),
              height: 30,
            ),
          ),
          Positioned.fill(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "08 Desember 2018",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Not Accepted",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w700),
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

class _TransactionNotProcess extends StatelessWidget {
  const _TransactionNotProcess({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        _buildDetail(),
        _buildCancelButton(context),
        _buildProductList()
      ]),
    );
  }

  Container _buildCancelButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
      width: ScreenUtil().setWidth(300),
      height: ScreenUtil().setHeight(40),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.white,
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) => CustomYesNoDialog(
                      yesButtonText: "Batalkan Transaksi",
                      noButtonText: "Kembali",
                      description: "Anda yakin ingin membatalkan transaksi?",
                      title: "Pembatalan transaksi",
                    ));
          },
          child: Center(
            child: Text(
              "Batalkan Trasaksi",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildDetail() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 3, offset: Offset(2, 2))
          ],
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(15),
          vertical: ScreenUtil().setWidth(5)),
      height: ScreenUtil().setHeight(180),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tanggal Pembelian",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
                "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 1,
                width: ScreenUtil().setWidth(300),
                child: Material(
                  color: Colors.grey,
                ),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Kode Transaksi",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text("7c3c7b7f-1458-4e39-9336-3681c246be8e",
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 1,
                width: ScreenUtil().setWidth(300),
                child: Material(
                  color: Colors.grey,
                ),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Total",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text("Rp. 200000",
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 1,
                width: ScreenUtil().setWidth(300),
                child: Material(
                  color: Colors.grey,
                ),
              )),
        ],
      ),
    );
  }

  _buildProductList() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black38, offset: Offset(2, 2), blurRadius: 2)
      ], borderRadius: BorderRadius.circular(5), color: Colors.white),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(4),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(4),
      ),
      child: ExpansionTile(
        title: Text(
          "Daftar barang ",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          Column(
            children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
                .map((_) => _TrasactionProductItem())
                .toList(),
          )
        ],
      ),
    );
  }
}

class _TrasactionProductItem extends StatelessWidget {
  const _TrasactionProductItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(3)),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black38, blurRadius: 2, offset: Offset(2, 2))
          ],
          borderRadius: BorderRadius.circular(5)),
      height: ScreenUtil().setHeight(50),
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          splashColor: Colors.green,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(3)),
                child: Text("Produk 1",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w700)),
              ),
              Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipPath(
                      clipper: _MProductClipper(),
                      child: Container(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(3)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("20 @ Rp 20000",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w700)),
                          Text("Rp. 200000",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionFinished extends StatelessWidget {
  const _TransactionFinished({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _TransactionCanceled extends StatelessWidget {
  const _TransactionCanceled({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _CustomNavigator extends StatefulWidget {
  const _CustomNavigator({
    Key key,
    this.pages,
    @required this.currentPage,
    this.changePage,
  }) : super(key: key);
  final List pages;
  final int currentPage;
  final Function changePage;
  @override
  __CustomNavigatorState createState() => __CustomNavigatorState();
}

class __CustomNavigatorState extends State<_CustomNavigator> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width / (widget.pages.length + 2);
    return Container(
      height: ScreenUtil().setHeight(50),
      color: Colors.green,
      child: Row(
          children: widget.pages
              .asMap()
              .map((index, element) => MapEntry(
                  index,
                  _NavigatorButton(
                      width: w,
                      page: widget.pages[index],
                      active: index == widget.currentPage,
                      changePage: () {
                        widget.changePage(index);
                      })))
              .values
              .toList()),
    );
  }
}

class _NavigatorButton extends StatelessWidget {
  _NavigatorButton(
      {Key key,
      @required this.width,
      @required this.active,
      this.changePage,
      this.page})
      : super(key: key);
  final double width;
  final Map<String, dynamic> page;
  final bool active;
  final Function changePage;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      curve: Curves.easeIn,
      width: active ? width * 3 : width,
      child: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 250),
            curve: Curves.easeIn,
            color: active ? Colors.white : Colors.green,
            width: double.maxFinite,
            height: double.maxFinite,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: active ? null : changePage,
                splashColor: Colors.green,
                child: Visibility(
                    visible: active,
                    replacement: Icon(
                      page["icon"],
                      color: Colors.white,
                    ),
                    child: Center(
                        child: Text(
                      page["label"],
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w700),
                    ))),
              ),
            ),
          ),
          Positioned(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeIn,
              color: active ? Colors.green : Colors.orange,
              height: 5,
              width: double.maxFinite,
            ),
            bottom: 0,
          ),
        ],
      ),
    );
  }
}

class _MProductClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width, h = size.height;
    final path = new Path();
    path.moveTo(w * 0.6, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(w * .5, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class _MHistoryClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final x = size.width, y = size.height;
    final path = new Path();
    path.lineTo(x * .4, 0);
    path.lineTo(x * .4, y);
    path.lineTo(0, y);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
