import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff13DF4C),
        title: Text("Pesan"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  _ProductWidget(
                    from: false,
                  ),
                  _MessageWidget(from: true),
                  _MessageWidget(from: false),
                ],
              ),
            ),
            Container(
              height: ScreenUtil().setHeight(60),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black38, blurRadius: 5, offset: Offset(0, -2))
              ]),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            maxLines: 5,
                            minLines: 1,
                          ))),
                  IconButton(
                    onPressed: () {},
                    color: Color(0xff13DF4C),
                    icon: Icon(Icons.send),
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

class _ProductWidget extends StatelessWidget {
  const _ProductWidget({Key key, this.from}) : super(key: key);
  final bool from;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: from ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: <Widget>[
        Container(
          height: ScreenUtil().setWidth(195),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: from ? Color(0xff13DF4C) : Color(0xff301530), width: 2)),
          child: Container(
            height: ScreenUtil().setWidth(160),
            child: Column(
              children: <Widget>[
                Container(
                  color: from ? Color(0xff13DF4C) : Color(0xff301530),
                  padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: CachedNetworkImage(
                    width: ScreenUtil().setWidth(120),
                    height: ScreenUtil().setWidth(160),
                    imageUrl: "https://picsum.photos/120/160",
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  width: ScreenUtil().setWidth(120),
                  child: Text("Benih Padi @ 5KG",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700),),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MessageWidget extends StatelessWidget {
  const _MessageWidget({
    Key key,
    @required this.from,
  }) : super(key: key);

  final bool from;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: from ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(300),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: from ? Colors.green : Color(0xff301530), width: 2)),
          child: Text(
            "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Magni laborum neque ipsam voluptate natus consequatur odio nihil placeat quo similique veritatis optio illum id explicabo, fugit, modi totam, sit fuga?",
            textAlign: TextAlign.justify,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
