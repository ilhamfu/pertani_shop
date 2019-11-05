import 'package:flutter/material.dart';
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
                  Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: TextField(maxLines: 5,minLines: 1,))),
                  IconButton(
                    onPressed: (){},
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
