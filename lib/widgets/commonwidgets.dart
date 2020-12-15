import 'package:flutter/material.dart';

SizedBox mySizedBox(
    {@required double myHeight, @required double myWidth, child}) {
  return SizedBox(
    height: double.parse("$myHeight"),
    width: double.parse("$myWidth"),
    child: child,
  );
}

Widget iLoderWidget() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
