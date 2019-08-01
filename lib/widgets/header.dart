import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({
    Key key
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchFocusNode.addListener((){
      setState(() {
        
      });
    });
  }

  @override
  void dispose() { 
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(2, 2, 2, 1),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                border: Border.all(color: Colors.green, width: 3)),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Expanded(
              child: TextField(
                  maxLines: 1,
                  focusNode: searchFocusNode,
                  decoration: InputDecoration(
                    hintText: "Search",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                  ))),
          !searchFocusNode.hasFocus
              ? Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    _CustomIconButton(
                      onTap: () {},
                      icon: Icons.chat,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    _CustomIconButton(
                      onTap: () {},
                      icon: Icons.notifications,
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class _CustomIconButton extends StatefulWidget {
  _CustomIconButton({Key key, @required this.onTap, @required this.icon})
      : super(key: key);

  final Function onTap;
  final IconData icon;

  __CustomIconButtonState createState() => __CustomIconButtonState();
}

class __CustomIconButtonState extends State<_CustomIconButton> {
  bool is_tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (detail) {
        setState(() {
          is_tapped = true;
        });
      },
      onTapCancel: () {
        setState(() {
          is_tapped = false;
        });
      },
      onTapUp: (detail) {
        setState(() {
          is_tapped = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        padding: EdgeInsets.fromLTRB(3, 3, 3, 2),
        decoration: BoxDecoration(
            color: !is_tapped ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green, width: 2)),
        child: Icon(
          widget.icon,
          color: !is_tapped ? Colors.white : Colors.green,
        ),
      ),
    );
  }
}
