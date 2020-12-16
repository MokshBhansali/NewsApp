import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/channelModels.dart';

var searchList = List<NewsSources>();

getChannel() async {
  String url =
      "https://newsapi.org/v2/sources?apiKey=d2d02e1c894c47beaa437c11509324d7";
  var result = await http.get(url);
  var objectResult = json.decode(result.body);
  var channelList = List<NewsSources>();

  for (var item in objectResult["sources"]) {
    NewsSources newsSources = NewsSources.fromJson(item);
    channelList.add(newsSources);
  }
  return channelList;
}
