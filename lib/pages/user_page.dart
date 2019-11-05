import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pertani_shop/pages/edit_profil_page.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key, this.logout}) : super(key: key);
  final Function logout;
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFAFAFA),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            "https://picsum.photos/300/300"))),
              ),
              Expanded(
                  child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setWidth(40),
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: widget.logout,
                          child: Icon(
                            Icons.power_settings_new,
                            color: Colors.white,
                            size: ScreenUtil().setWidth(30),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(5),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setWidth(40),
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: Material(
                        shape: CircleBorder(),
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          splashColor: Colors.white,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (ctx)=>EditProfilePage()
                            ));
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: ScreenUtil().setWidth(30),
                          ),
                        )),
                  )
                ],
              )),
            ],
          ),
          Text("Ilham Fajri Umar",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(30))),
          Text("999392939291939",
              style: TextStyle(fontSize: ScreenUtil().setSp(15))),
          _Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: ScreenUtil().setHeight(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Alamat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        "Gg Hj Razak No. 14a, Gedong Meneng, Rajabasa",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                      flex: 3,
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Kabupaten",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        "Bandar Lampung",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                      flex: 3,
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Provinsi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        "Lampung",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                      flex: 3,
                    )
                  ],
                ),
              ],
            ),
          ),
          _Divider(),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 2,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.green,
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2))]));
  }
}
