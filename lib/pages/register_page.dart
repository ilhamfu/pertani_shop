import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

const Color primaryColor = Color(0xFF13DF4C);
const Color secondaryColor = Color(0xFFC5EC3E);

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int step = 1;
  int stepMode = 0;
  PageController pageController = PageController(initialPage: 0);

  void nextPage() async {
    stepMode = 0;
    step = step + 1;
    if (step>=4){
      await Future.delayed(Duration(milliseconds: 200));
      Navigator.of(context).popUntil((Route route){
        return route.isFirst;
      });
    }
    setState(() {
      if (step < 4) {
        pageController.animateToPage(step - 1,
            duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      }
    });
  }

  Future<bool> prevPage() async {
    if (step > 1) {
      setState(() {
        stepMode = 1;
        step = step - 1;
        pageController.animateToPage(step - 1,
            duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      });
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: prevPage,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: ProgressBar(step: step, stepMode: stepMode),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.5),
                        offset: Offset(0, 4),
                        blurRadius: 4)
                  ]),
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      _AuthenticationPage(nextPage: nextPage),
                      _ProfilePage(nextPage: nextPage),
                      KTPPicturePage(nextPage: nextPage)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KTPPicturePage extends StatefulWidget {
  KTPPicturePage({Key key, this.nextPage}) : super(key: key);
  final Function nextPage;
  _KTPPicturePageState createState() => _KTPPicturePageState();
}

class _KTPPicturePageState extends State<KTPPicturePage> {
  File _image;
  Future _imageFuture;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      image = await ImageCropper.cropImage(
        sourcePath: image.path,
        ratioX: 86,
        ratioY: 54,
        toolbarColor: primaryColor,
        statusBarColor: primaryColor,
        toolbarWidgetColor: Colors.white,
      );
    }
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 5),
                        blurRadius: 5)
                  ]),
                  child: _image != null
                      ? Image.file(
                          _image,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        )
                      : Image.asset("assets/ktp_placeholder.png")),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton(
                      icon: Icons.camera_alt,
                      text: "Dari Kamera",
                      onTap: () {
                        getImage(ImageSource.camera);
                      }),
                  _buildButton(
                      icon: Icons.image,
                      text: "Dari Galeri",
                      onTap: () {
                        getImage(ImageSource.gallery);
                      }),
                ],
              )
            ],
          )),
        ),
        Container(
          color: primaryColor,
          height: 60,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white,
              onTap: () {
                widget.nextPage();
              },
              child: Center(
                child: Text(
                  "Selanjutnya",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Container _buildButton({IconData icon, String text, Function onTap}) {
    return Container(
      height: ScreenUtil().setWidth(40),
      width: ScreenUtil().setWidth(160),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
                size: ScreenUtil().setWidth(30),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(5),
              ),
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(16)),
              ),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(5, 5), blurRadius: 5)
          ]),
    );
  }
}

class _ProfilePage extends StatefulWidget {
  _ProfilePage({Key key, this.nextPage}) : super(key: key);
  final Function nextPage;
  __ProfilePageState createState() => __ProfilePageState();
}

class __ProfilePageState extends State<_ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(10)),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Text(
                    "Data Diri",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: primaryColor, boxShadow: [
                      BoxShadow(color: primaryColor)
                    ]),
                  ),
                  _CustomTextField(
                    hint: "Nama Depan",
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  _CustomTextField(
                    hint: "Nama Belakang",
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  _CustomTextField(
                    hint: "No NIK",
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    "Alamat",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: primaryColor, boxShadow: [
                      BoxShadow(color: primaryColor)
                    ]),
                  ),
                  _CustomTextField(
                    hint: "Alamat",
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  _CustomTextField(
                    hint: "Kota/Kabupaten",
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  _CustomTextField(
                    hint: "Provinsi",
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          color: primaryColor,
          height: 60,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white,
              onTap: () {
                // if (formKey.currentState.validate()) {}
                if (FocusScope.of(context).hasFocus){
                  FocusScope.of(context).unfocus();
                }
                widget.nextPage();
                
              },
              child: Center(
                child: Text(
                  "Selanjutnya",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _AuthenticationPage extends StatefulWidget {
  _AuthenticationPage({Key key, this.nextPage}) : super(key: key);
  final Function nextPage;
  __AuthenticationPageState createState() => __AuthenticationPageState();
}

class __AuthenticationPageState extends State<_AuthenticationPage> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController emailController,
      passwordController,
      confirmPasswordController;

  @override
  void initState() {
    super.initState();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    confirmPasswordController = new TextEditingController();
  }

  @override
  void dispose() {
    emailController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();
    super.dispose();
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return "Email tidak boleh kosong";
    if (!regex.hasMatch(value)) return 'Masukan email yang valid';
    return null;
  }

  String validatePassword(String value) {
    Pattern pattern =
        r"^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{8,})";
    RegExp regExp = new RegExp(pattern);

    if (value.length < 8) return "Password setidaknya 8 karakter";

    if (!regExp.hasMatch(value)) {
      return "Password Kurang kuat";
    }
    return null;
  }

  String validateConfirmationPassword(String value) {
    if (value != passwordController.text)
      return "Konfirmasi paassword tidak sama";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(8),
                vertical: ScreenUtil().setHeight(10)),
            child: Form(
              key: formKey,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  _CustomTextField(
                    hint: "Email",
                    validator: validateEmail,
                    textEditingController: emailController,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  _CustomTextField(
                    hint: "Password",
                    obscureText: true,
                    validator: validatePassword,
                    textEditingController: passwordController,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  _CustomTextField(
                    validator: validateConfirmationPassword,
                    hint: "Konfirmasi Password",
                    obscureText: true,
                    textEditingController: confirmPasswordController,
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          color: primaryColor,
          height: 60,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white,
              onTap: () {
                if (formKey.currentState.validate()) {}
                FocusScope.of(context).unfocus();
                widget.nextPage();
              },
              child: Center(
                child: Text(
                  "Selanjutnya",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField(
      {Key key,
      this.hint,
      this.textEditingController,
      this.obscureText = false,
      this.maxLines = 1,
      this.validator})
      : super(key: key);

  final String hint;
  final TextEditingController textEditingController;
  final bool obscureText;
  final Function validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      obscureText: obscureText,
      validator: validator,
      controller: textEditingController,
      maxLines: maxLines,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.all(ScreenUtil().setWidth(12)),
          hintText: hint),
    );
  }
}

class ProgressBar extends StatefulWidget {
  ProgressBar({Key key, this.step, this.stepMode}) : super(key: key);

  final int step;
  final int stepMode;

  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> tween;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    tween = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: controller));
  }

  @override
  Widget build(BuildContext context) {
    controller.reset();
    controller.forward();
    return AnimatedBuilder(
      animation: tween,
      builder: (BuildContext context, Widget child) {
        return CustomPaint(
          painter: _ProgressPainter(
              step: widget.step+widget.stepMode,
              fraction: (widget.stepMode - tween.value).abs()),
          child: Container(
            height: 70,
          ),
        );
      },
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final int step;
  final double fraction;

  _ProgressPainter({this.step = 1, this.fraction = 0});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 5;

    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    double yOffset = (size.height) / 2;

    canvas.drawLine(Offset(0, yOffset), Offset(size.width, yOffset), paint);
    paint.color = primaryColor;
    canvas.drawLine(
        Offset(0, yOffset),
        Offset((0.25 * (step - 1) + (.25 * (fraction))) * size.width, yOffset),
        paint);
    paint.color = Colors.grey;

    paint.style = PaintingStyle.fill;
    for (int i = 1; i < 4; i++) {
      if (i < step) {
        paint.color = primaryColor;
        canvas.drawCircle(Offset(0.25 * i * size.width, yOffset), 5, paint);
        paint.color = Colors.grey;
      } else {
        canvas.drawCircle(Offset(0.25 * i * size.width, yOffset), 5, paint);
      }
    }

    paint.color = primaryColor;
    if (step < 4)
      canvas.drawCircle(
          Offset(0.25 * step * size.width, yOffset), 5 * fraction, paint);
  }

  @override
  bool shouldRepaint(_ProgressPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_ProgressPainter oldDelegate) => false;
}
