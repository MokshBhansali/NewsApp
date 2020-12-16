import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/channelNewsModel.dart';
  var searchList1 = List<Articles>();

getnewsDataViewDAta(var newsUrl) async {
  String url =
      "https://newsapi.org/v2/everything?domains=$newsUrl&apiKey=d2d02e1c894c47beaa437c11509324d7";
  var result = await http.get(url);
  var response = json.decode(result.body);
  var newsList = List<Articles>();


  for (var item in response["articles"]) {
    Articles articles = Articles.fromJson(item);
    newsList.add(articles);
  }
  print(newsList.length);
  return newsList;
}
