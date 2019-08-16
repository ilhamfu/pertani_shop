import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
            height: ScreenUtil().setHeight(150),
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: ScreenUtil().setHeight(100),
                    width: ScreenUtil().setWidth(340),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 17,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/qr_placeholder.png")),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(-3, -3),
                            blurRadius: 3)
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: ScreenUtil().setWidth(75),
                    width: ScreenUtil().setWidth(75),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: Colors.green,
                        onTap: () {
                          _buildShowDialog(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
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

class _TransactionNotProcess extends StatelessWidget {
  const _TransactionNotProcess({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 3,
                      offset: Offset(2, 2))
                ],
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
                vertical: ScreenUtil().setWidth(5)),
            height: ScreenUtil().setHeight(120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tanggal Pembelian",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
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
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
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
              ],
            ),
          ),
          Container(
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
          )
        ],
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
