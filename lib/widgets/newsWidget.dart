import 'package:flutter/material.dart';
import '../global/colors.dart';
import '../utils/passArguments.dart';
import '../utils/screenUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'commonwidgets.dart';
import 'package:timeago/timeago.dart' as timeago;

getNewsDataWidget(context, myData) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      Navigator.pushNamed(context, "/DetailScreen",
          arguments: PassArguments(
            date: myData.publishedAt,
            description: myData.description,
            newsSource: myData.source,
            image: myData.urlToImage,
            title: myData.title,
            url: myData.url,
            content: myData.content,
          ));
    },
    child: Container(
      height: 110,
      width: getScreenWidth(context, 0.35),
      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
      decoration: BoxDecoration(
        color: ColorPlate.WhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(0, 3.0),
            blurRadius: 6.0,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          mySizedBox(myHeight: 0, myWidth: 5),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    myData.source.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    myData.title.toString(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(timeUntil(DateTime.parse(myData.publishedAt)))
                ],
              )),
          mySizedBox(myHeight: 0, myWidth: 10),
          Expanded(
            flex: 1,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  top: -20,
                  right: 7,
                  bottom: 15,
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: myData.urlToImage ??
                          "https://rimatour.com/wp-content/uploads/2017/09/No-image-found.jpg",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                    width: getScreenWidth(context, 0.15),
                  ),
                ),
              ],
            ),
          ),
          mySizedBox(myHeight: 0, myWidth: 5)
        ],
      ),
    ),
  );
}

String timeUntil(DateTime date) {
  return timeago.format(date, allowFromNow: true);
}
