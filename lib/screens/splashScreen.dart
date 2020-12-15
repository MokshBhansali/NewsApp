import 'dart:io';
import 'package:flutter/material.dart';
import '../global/images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  startAnimation() {
    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween<double>(begin: 0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
    animation.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Navigator.pushReplacementNamed(context, "/HomeScreen");
          }
        } on SocketException catch (_) {
          Navigator.pushReplacementNamed(context, "/NoNetwork");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: animation.value,
          duration: Duration(milliseconds: 500),
          child: Image.asset(MyImage.AppLogo, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
