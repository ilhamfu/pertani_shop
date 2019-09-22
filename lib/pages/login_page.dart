import 'package:flutter/material.dart';
import 'package:pertani_shop/utils/pertani_icon_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color primaryColor = Color(0xFF13DF4C);
const Color secondaryColor = Color(0xFFC5EC3E);

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.login}) : super(key: key);
  final Function login;
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: new _LoginPageBody(login:widget.login)),
        ),
      ),
    );
  }
}

class _LoginPageBody extends StatelessWidget {
  const _LoginPageBody({
    Key key, this.login,
  }) : super(key: key);

  final Function login;

  void loginTwitter() {
    print("Login With Twitter");
    login();
  }

  void loginEmail() {
    print("Login With Email");
    login();
  }

  void loginFacebook() {
    print("Login With Facebook");
    login();
  }

  void loginGoogle() {
    print("Login With Google");
    login();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        Container(
          width: ScreenUtil().setWidth(160),
          height: ScreenUtil().setWidth(160),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                  offset: Offset(0, 4))
            ],
            image: DecorationImage(image: AssetImage("assets/logo.png")),
          ),
        ),
        new _LoginControl(loginEmail: loginEmail),
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.white.withOpacity(.5), blurRadius: 4)
          ]),
          margin: EdgeInsets.symmetric(vertical: 16),
          height: ScreenUtil().setHeight(5),
        ),
        new _SocialLogin(
          loginFacebook: loginFacebook,
          loginGoogle: loginGoogle,
          loginTwitter: loginTwitter,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        Text(
          "Belum punya akun?",
          style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: ScreenUtil().setWidth(260),
          height: ScreenUtil().setWidth(40),
          decoration: BoxDecoration(
              color: Color(0xff301530),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.5),
                    offset: Offset(0, 4),
                    blurRadius: 4)
              ]),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              splashColor: Colors.white,
              onTap: () {
                Navigator.of(context).pushNamed("/register");
              },
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: Text("Daftar",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(18))),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SocialLogin extends StatelessWidget {
  const _SocialLogin({
    Key key,
    this.loginTwitter,
    this.loginFacebook,
    this.loginGoogle,
  }) : super(key: key);

  final Function loginTwitter, loginFacebook, loginGoogle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Atau login menggunakan",
          style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(16),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              {
                "color": Color(0xff385cbe),
                "icon": PertaniIcon.facebook,
                "onTap": loginFacebook
              },
              {
                "color": Color(0xff76A9EA),
                "icon": PertaniIcon.twitter,
                "onTap": loginTwitter
              },
              {
                "color": Color(0xff7f34a38),
                "icon": PertaniIcon.google_plus,
                "onTap": loginGoogle
              },
            ]
                .map(
                  (element) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setWidth(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.5),
                            blurRadius: 4,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: element["onTap"],
                        splashColor: primaryColor,
                        child: Center(
                          child: Icon(
                            element["icon"],
                            color: element["color"],
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList())
      ],
    );
  }
}

class _LoginControl extends StatefulWidget {
  const _LoginControl({
    Key key,
    this.loginEmail,
  }) : super(key: key);

  final Function loginEmail;

  @override
  __LoginControlState createState() => __LoginControlState();
}

class __LoginControlState extends State<_LoginControl> {
  GlobalKey<FormState> _form = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      child: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                
                maxLines: 1,
                style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(26),
                        top: ScreenUtil().setHeight(11),
                        bottom: ScreenUtil().setHeight(11)),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Email"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(26),
                        top: ScreenUtil().setHeight(11),
                        bottom: ScreenUtil().setHeight(11)),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Password"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              width: ScreenUtil().setWidth(260),
              height: ScreenUtil().setWidth(40),
              decoration: BoxDecoration(
                  color: Color(0xff301530),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.5),
                        offset: Offset(0, 4),
                        blurRadius: 4)
                  ]),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.loginEmail,
                  child: Center(
                      child: Text("Masuk",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(18)))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
