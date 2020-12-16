import 'package:flutter/material.dart';
import '../global/appStrings.dart';
import '../global/colors.dart';
import '../utils/passArguments.dart';
import '../utils/screenUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/commonwidgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final PassArguments arguments;
  DetailScreen({this.arguments});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.widget.arguments.title.toString(),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: getScrennheight(context, 0.35),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: this.widget.arguments.image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.add_alert_outlined),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 10,
                  //   left: 5,
                  //   right: 5,
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         this.widget.arguments.title.toString(),
                  //         maxLines: 2,
                  //         style: GoogleFonts.poppins(
                  //           color: ColorPlate.WhiteColor,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            mySizedBox(myHeight: 20, myWidth: 0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.widget.arguments.title.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ColorPlate.BlackColor),
                  ),
                  mySizedBox(myHeight: 10, myWidth: 0),
                  Text(
                    this.widget.arguments.newsSource.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(this.widget.arguments.date.substring(0, 10).toString()),
                  mySizedBox(myHeight: 10, myWidth: 0),
                  Text(
                    this.widget.arguments.content.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                if (await canLaunch(this.widget.arguments.url)) {
                  await launch(this.widget.arguments.url);
                } else {
                  throw 'Could not launch ${this.widget.arguments.url}';
                }
              },
              child: Row(
                children: [
                  Text(
                    App.SeeFullStory,
                    style: TextStyle(color: ColorPlate.BlueColor),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 13,
                    color: ColorPlate.BlueColor,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
