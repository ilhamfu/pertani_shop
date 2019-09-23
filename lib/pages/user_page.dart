import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key, this.logout}) : super(key: key);
  final Function logout;
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        RaisedButton(onPressed: widget.logout,)
      ],),
    );
  }
}
