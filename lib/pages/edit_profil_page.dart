import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const primaryColor = Color(0xFF13DF4C);

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff13DF4C),
        appBar: AppBar(
          actions: <Widget>[IconButton(icon: Icon(Icons.save),onPressed: (){},)],
            centerTitle: true,
            title: Text("Ubah Profil"),
            backgroundColor: primaryColor),
        body: Container(
            color: Colors.white,
            child: _ProfilePage()));
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
    return Container(
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
              decoration: BoxDecoration(
                  color: primaryColor,
                  boxShadow: [BoxShadow(color: primaryColor)]),
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
              decoration: BoxDecoration(
                  color: primaryColor,
                  boxShadow: [BoxShadow(color: primaryColor)]),
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
