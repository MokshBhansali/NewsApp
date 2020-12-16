import 'package:flutter/cupertino.dart';
import 'screens/detailScreen.dart';
import 'screens/channelDetail.dart';
import 'screens/homeScreen.dart';
import 'screens/noNetwork.dart';
import 'screens/splashScreen.dart';

var routes = <String, WidgetBuilder>{
  "/": (context) => SplashScreen(),
  "/HomeScreen": (context) => HomeScreen(),
  "/DetailScreen": (context) =>
      DetailScreen(arguments: ModalRoute.of(context).settings.arguments),
  "/NoNetwork": (context) => NoNetwork(),
  "/ChannelDetail": (context) =>
      ChannelDetail(arguments: ModalRoute.of(context).settings.arguments),
};
