import 'package:flutter/material.dart';
import '../global/appStrings.dart';
import '../global/colors.dart';
import '../global/images.dart';
import '../utils/screenUtils.dart';
import '../widgets/commonwidgets.dart';

class NoNetwork extends StatefulWidget {
  @override
  _NoNetworkState createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App.NoNetwork),
      ),
      body: Container(
        height: getScrennheight(context, 1.0),
        width: getScreenWidth(context, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              MyImage.NoNetworkImage,
              height: 100,
            ),
            mySizedBox(myHeight: 20, myWidth: 0),
            Text(App.NoNetwork),
            mySizedBox(myHeight: 10, myWidth: 0),
            RaisedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, "/"),
              child: Text(App.Retry),
              color: ColorPlate.BlueColor,
              textColor: ColorPlate.WhiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
