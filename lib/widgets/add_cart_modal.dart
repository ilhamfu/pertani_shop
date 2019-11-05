import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/models/product.dart';



class AddToCartWidget extends StatefulWidget {
  AddToCartWidget({Key key, this.product, this.amount=1}) : super(key: key);

  final Product product;
  final int amount;

  _AddToCartWidgetState createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<AddToCartWidget> {
  TextEditingController _textEditingController = new TextEditingController();
  int _amount;
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _amount = widget.amount;
    _textEditingController.text = _amount.toString();
  }

  _increment() {
    setState(() {
      _textEditingController.text =
          (_amount < widget.product.stock ? ++_amount : _amount).toString();
      _textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textEditingController.text.length));
    });
  }

  _decrement() {
    setState(() {
      _textEditingController.text =
          (_amount > 1 ? --_amount : _amount).toString();
      _textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textEditingController.text.length));
    });
  }

  _onChanged(String value) {
    var temp = value;
    if (temp == "") temp = "0";

    setState(() {
      _amount = int.parse(temp) < widget.product.stock
          ? int.parse(temp)
          : widget.product.stock;
      _textEditingController.text = _amount.toString();
      _textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textEditingController.text.length));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: ScreenUtil().setHeight(200) +
          MediaQuery.of(context).viewInsets.bottom,
      child: Column(
        children: <Widget>[
          Container(
            height: 30,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black)],
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            child: Icon(Icons.drag_handle),
          ),
          Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black)],
                color: Colors.white),
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setWidth(10),
                horizontal: ScreenUtil().setWidth(5)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.lightGreen,
                            blurRadius: 0,
                            offset: Offset(-3, -3))
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.product.imageList[0] ?? "",
                      height: ScreenUtil().setHeight(100),
                      width: ScreenUtil().setHeight(75),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${widget.product.name}",
                              style: TextStyle(
                                  color: Color(0xFF13DF4C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(18)),
                            ),
                            Text("Rp ${widget.product.price}",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(13))),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          _buildAmountControl(),
                          SizedBox(
                            width: ScreenUtil().setWidth(5),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(145),
                            height: ScreenUtil().setHeight(30),
                            child: Stack(
                              children: <Widget>[
                                ClipPath(
                                  clipper: _MClipper(),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(2)),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.orange,
                                              width: ScreenUtil().setWidth(2)),
                                          bottom: BorderSide(
                                              color: Colors.orange,
                                              width: ScreenUtil().setWidth(2))),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Total",
                                          style: TextStyle(
                                              color: Color(0xFF13DF4C),
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ScreenUtil().setSp(15))),
                                      Text(
                                          "Rp. ${_amount * widget.product.price}",
                                          style: TextStyle(
                                              color: Color(0xFF13DF4C),
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(15)))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                    width: ScreenUtil().setWidth(180),
                    height: ScreenUtil().setHeight(50),
                    child: Material(
                      color: Colors.red,
                      child: InkWell(
                        onTap: () {Navigator.of(context).pop(0);},
                        child: Center(
                          child: Text(
                            "Batal",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )),
                Container(
                    width: ScreenUtil().setWidth(180),
                    height: ScreenUtil().setHeight(50),
                    child: Material(
                      color: _amount >= 1 ? Color(0xFF13DF4C) : Colors.grey,
                      child: InkWell(
                        onTap: _amount >= 1
                            ? () {
                                Navigator.of(context).pop(_amount);
                              }
                            : null,
                        child: Center(
                          child: Text(
                            "Simpan",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _buildAmountControl() {
    return Row(
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setWidth(30),
          width: ScreenUtil().setWidth(30),
          child: Material(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
            color: _amount > 1 ? Colors.orange : Colors.grey,
            child: InkWell(
              splashColor: Colors.white,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
              onTap: _amount > 1 ? _decrement : null,
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
            width: ScreenUtil().setWidth(50),
            child: TextField(
                textAlign: TextAlign.center,
                controller: _textEditingController,
                maxLines: 1,
                onChanged: _onChanged,
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(ScreenUtil().setWidth(4)),
                ))),
        SizedBox(
          height: ScreenUtil().setWidth(30),
          width: ScreenUtil().setWidth(30),
          child: Material(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
            color: _amount < widget.product.stock ? Colors.orange : Colors.grey,
            child: InkWell(
              splashColor: Colors.white,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
              onTap: _amount < widget.product.stock ? _increment : null,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _MClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * .75, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
