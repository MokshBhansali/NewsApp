import 'package:flutter/material.dart';
import 'package:newsapp/services/getChannelNews.dart';
import 'package:newsapp/utils/passArguments.dart';
import 'package:newsapp/widgets/commonwidgets.dart';
import 'package:newsapp/widgets/newsWidget.dart';

class ChannelDetail extends StatefulWidget {
  final NewsChannelName arguments;
  ChannelDetail({this.arguments});
  @override
  _ChannelDetailState createState() => _ChannelDetailState();
}

class _ChannelDetailState extends State<ChannelDetail> {
  @override
  Widget build(BuildContext context) {
    print(this.widget.arguments.url.split("/").last);
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.arguments.name),
      ),
      body: FutureBuilder(
        future: getnewsDataViewDAta(
            this.widget.arguments.url.split("/").last.split("www.").last),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var myData = snapshot.data[index];
                if (snapshot.data.length == 0 || snapshot.data == null) {
                  return Center(
                    child: Text(
                      "No News Found From ${this.widget.arguments.name}",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                } else
                  return getNewsDataWidget(context, myData);
              },
            );
          } else {
            return iLoderWidget();
          }
        },
      ),
    );
  }
}
