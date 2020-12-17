import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/channelModels.dart';

var searchList = List<NewsSources>();

getChannel() async {
  String url =
      "https://newsapi.org/v2/sources?apiKey=01999c1172bf48d7a91942e7d1cfb954";
  var result = await http.get(url);
  var objectResult = json.decode(result.body);
  var channelList = List<NewsSources>();

  for (var item in objectResult["sources"]) {
    NewsSources newsSources = NewsSources.fromJson(item);
    channelList.add(newsSources);
  }
  return channelList;
}
