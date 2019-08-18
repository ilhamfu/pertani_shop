import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomYesNoDialog extends StatelessWidget {
  final String title, description, yesButtonText, noButtonText;
  final Image image;

  CustomYesNoDialog({
    @required this.title,
    @required this.description,
    @required this.yesButtonText,
    @required this.noButtonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setWidth( 31),
            bottom: ScreenUtil().setWidth(8),
            left: ScreenUtil().setWidth(8),
            right: ScreenUtil().setWidth(8),
          ),
          margin: EdgeInsets.only(top: 31),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Center(
                            child: Text(
                              noButtonText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      height: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Center(
                            child: Text(
                              yesButtonText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      height: 30,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        _DialogIcon() //...top circlular image part,
      ],
    );
  }
}

class _DialogIcon extends StatelessWidget {
  const _DialogIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      child: CircleAvatar(
        backgroundColor: Colors.green,
        radius: 30,
      ),
    );
  }
}
