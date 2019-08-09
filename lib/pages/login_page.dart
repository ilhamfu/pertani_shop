import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 360, height: 640, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Container(
          child: _LoginPageBody(),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.orange,
              Colors.green,
              Colors.white,
              Colors.green,
              Colors.orange,
              Colors.white,
              Colors.orange,
              Colors.green,
              Colors.orange
            ], stops: [
              0.01,
              0.3,
              0.35,
              0.4,
              0.45,
              0.5,
              0.6,
              0.8,
              1
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _LoginPageBody extends StatefulWidget {
  const _LoginPageBody({Key key}) : super(key: key);

  @override
  __LoginPageBodyState createState() => __LoginPageBodyState();
}

class __LoginPageBodyState extends State<_LoginPageBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil().setWidth(250),
              width: ScreenUtil().setWidth(250),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                        "https://picsum.photos/id/1/300/400",
                      ))),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            TextField(
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Email",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(10),
                      vertical: ScreenUtil().setWidth(8))),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            TextField(
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
              maxLines: 1,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Password",
                  errorMaxLines: 1,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(10),
                      vertical: ScreenUtil().setWidth(8))),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(280),
                  height: ScreenUtil().setHeight(40),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(5),
                      child: Center(
                          child: Text(
                        "Log in",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Container(
                  color: Colors.white,
                  width: 280,
                  height: 2,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.golf_course),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.golf_course),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.golf_course),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Container(
                  color: Colors.white,
                  width: 180,
                  height: 2,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
