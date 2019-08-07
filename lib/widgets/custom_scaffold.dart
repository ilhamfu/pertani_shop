import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {Key key,
      this.body,
      this.bottomNavigationBar,
      this.drawer,
      this.endDrawer,
      this.floatingActionButton})
      : super(key: key);
  final Widget body;
  final Widget bottomNavigationBar;
  final Widget drawer;
  final Widget endDrawer;
  final Widget floatingActionButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: body,
        ),
      ),
    );
  }
}
