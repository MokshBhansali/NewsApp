import 'package:flutter/material.dart';
import './global/appStrings.dart';
import './global/colors.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: App.AppName,
      theme: ThemeData(
        primarySwatch: ColorPlate.BlueColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: routes,
    );
  }
}
