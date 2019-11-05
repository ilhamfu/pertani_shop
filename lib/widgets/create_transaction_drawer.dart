import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum _PaymentMethod { cod, transfer }

class CreateTransactionDrawer extends StatefulWidget {
  CreateTransactionDrawer({Key key}) : super(key: key);

  _CreateTransactionDrawerState createState() =>
      _CreateTransactionDrawerState();
}

class _CreateTransactionDrawerState extends State<CreateTransactionDrawer> {
  _PaymentMethod _paymentMethod = _PaymentMethod.cod;

  _changePayment(_PaymentMethod paymentMethod) {
    setState(() {
      this._paymentMethod = paymentMethod;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff13DF4C),
      width: MediaQuery.of(context).size.width * .75,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _buildHeader(),
              Expanded(
                  child: Column(
                children: <Widget>[
                  new _TotalWidget(),
                  Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(5)),
                      decoration: BoxDecoration(
                        color: Color(0xff13DF4C),
                        boxShadow: [
                          BoxShadow(color: Color(0xff13DF4C), blurRadius: 5)
                        ],
                      )),
                  _PaymentWidget(
                    onChange: _changePayment,
                    paymentMethod: _paymentMethod,
                  ),
                  Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(5)),
                      decoration: BoxDecoration(
                        color: Color(0xff13DF4C),
                        boxShadow: [
                          BoxShadow(color: Color(0xff13DF4C), blurRadius: 5)
                        ],
                      )),
                  new _ShipmentWidget()
                ],
              )),
              Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(50),
                color: Color(0xff13DF4C),
                child: Center(
                    child: Text(
                  "Buat Transaksi",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(15)),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      color: Color(0xff13DF4C),
      height: ScreenUtil().setWidth(50),
      child: Center(
        child: Text(
          "Detail Transaksi",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(20)),
        ),
      ),
    );
  }
}

class _ShipmentWidget extends StatelessWidget {
  const _ShipmentWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Pengiriman",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(15))),
          Container(
              height: 1,
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(2)),
              decoration: BoxDecoration(
                color: Color(0xff13DF4C),
                boxShadow: [BoxShadow(color: Color(0xff13DF4C), blurRadius: 5)],
              )),
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Text("Alamat",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(14)))),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Gg Hj Razak No. 14a, Gedong Meneng, Rajabasa",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(5),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Text("Kabupaten/Kota",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(14)))),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Bandar Lampung",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(5),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Text("Provinsi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(14)))),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Lampung",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
              height: 1,
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(2)),
              decoration: BoxDecoration(
                color: Color(0xff13DF4C),
                boxShadow: [BoxShadow(color: Color(0xff13DF4C), blurRadius: 5)],
              )),
          Container(
            color: Color(0xff13DF4C),
            height: 30,
            width: double.infinity,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                splashColor: Colors.white,
                child: Center(
                    child: Text(
                  "Gunakan Alamat Lain",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TotalWidget extends StatelessWidget {
  const _TotalWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(100),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Total Produk",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(15)),
                ),
              ),
              Expanded(flex: 1,child: Container(),),
              Expanded(
                flex: 2,
                child: Text("Rp. 200000",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(15))),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Biaya Kirim",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(15)),
                ),
              ),
              Expanded(flex: 1,child: Container(),),
              Expanded(
                flex: 2,
                child: Text("Rp. 200000",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(15))),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Total",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(15)),
                ),
              ),
              Expanded(flex: 1,child: Container(),),
              Expanded(
                flex: 2,
                child: Text("Rp. 200000",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(15))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentWidget extends StatelessWidget {
  const _PaymentWidget({Key key, this.paymentMethod, this.onChange})
      : super(key: key);

  final _PaymentMethod paymentMethod;
  final Function onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(65),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Text("Pembayaran",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(15)))),
            Expanded(
                flex: 3,
                child: _PayementChoice(
                    paymentMethod: paymentMethod, onChange: onChange))
          ],
        ));
  }
}

class _PayementChoice extends StatelessWidget {
  const _PayementChoice({Key key, this.paymentMethod, this.onChange})
      : super(key: key);
  final _PaymentMethod paymentMethod;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Color(0xff13DF4C),
              onTap: paymentMethod == _PaymentMethod.cod
                  ? null
                  : () {
                      onChange(_PaymentMethod.cod);
                    },
              child: Row(
                children: <Widget>[
                  AnimatedContainer(
                    height: ScreenUtil().setWidth(25),
                    width: ScreenUtil().setWidth(25),
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    decoration: BoxDecoration(
                        color: paymentMethod == _PaymentMethod.cod
                            ? Color(0xff13DF4C)
                            : Colors.red,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              blurRadius: 2,
                              offset: Offset(2, 2))
                        ]),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  Text(
                    "Bayar di Tempat",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Color(0xff13DF4C),
              onTap: paymentMethod != _PaymentMethod.cod
                  ? null
                  : () {
                      onChange(_PaymentMethod.transfer);
                    },
              child: Row(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    height: ScreenUtil().setWidth(25),
                    width: ScreenUtil().setWidth(25),
                    decoration: BoxDecoration(
                        color: paymentMethod != _PaymentMethod.cod
                            ? Color(0xff13DF4C)
                            : Colors.red,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              blurRadius: 2,
                              offset: Offset(2, 2))
                        ]),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  Text(
                    "Transfer",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
