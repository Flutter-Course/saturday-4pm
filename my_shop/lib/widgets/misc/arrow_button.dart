import 'package:flutter/material.dart';

class ArrowButton extends FlatButton {
  ArrowButton.left({
    @required String child,
    @required Function onPressed,
  }) : super(
          padding: EdgeInsets.only(left: 20),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          color: Colors.black,
          child: Text(
            child,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onPressed,
        );
  ArrowButton.right({
    @required String child,
    @required Function onPressed,
  }) : super(
          padding: EdgeInsets.only(right: 20),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          color: Colors.black,
          child: Text(
            child,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onPressed,
        );
}
