import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/channelNewsModel.dart';
  var searchList1 = List<Articles>();

getnewsDataViewDAta(var newsUrl) async {
  String url =
      "https://newsapi.org/v2/everything?domains=$newsUrl&apiKey=01999c1172bf48d7a91942e7d1cfb954";
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
