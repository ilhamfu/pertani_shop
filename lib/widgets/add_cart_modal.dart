import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/models/product.dart';

buildAddToCart({@required BuildContext context, @required Product product}) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      builder: (ctx) => _AddToCartWidget(
            product: product,
          ),
      isScrollControlled: true);
}

class _AddToCartWidget extends StatefulWidget {
  _AddToCartWidget({Key key, this.product}) : super(key: key);

  final Product product;

  _AddToCartWidgetState createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<_AddToCartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(),
      height: ScreenUtil().setHeight(200),
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
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 10.0, right: 5, left: 5),
            child: Expanded(
                          child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(2, 2))
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
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(18)),
                              ),
                              Text("Rp ${widget.product.price}"),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildAmountControl(),
                            Column(children: <Widget>[
                              Text("Total"),
                              Text("200000")
                            ],)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
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
          height: 30,
          width: 30,
          child: Material(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
            color: Colors.orange,
            child: InkWell(
              splashColor: Colors.white,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
              onTap: () {},
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
            width: ScreenUtil().setWidth(50),
            child: TextField(
                decoration: InputDecoration(
              contentPadding: EdgeInsets.all(ScreenUtil().setWidth(4)),
            ))),
        SizedBox(
          height: 30,
          width: 30,
          child: Material(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
            color: Colors.orange,
            child: InkWell(
              splashColor: Colors.white,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
              onTap: () {},
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
