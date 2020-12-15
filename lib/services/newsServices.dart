import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/newsModel.dart';

class SearchResult {
  List<Articles> searchResult = [];
  List<Articles> allResult = [];
}

getData(int displayData, String country) async {
  String url =
      "http://newsapi.org/v2/top-headlines?country=$country&category=business&apiKey=01999c1172bf48d7a91942e7d1cfb954";
  var result = await http.get(url);
  var objectResult = json.decode(result.body);
  var userModelList = List<Articles>();
  var cnt = 0;

  for (var item in objectResult["articles"]) {
    if (cnt < displayData) {
      Articles articles = Articles(
        author: item['author'],
        content: item['content'],
        description: item['description'],
        publishedAt: item['publishedAt'],
        title: item['title'],
        source: item['source']['name'],
        url: item['url'],
        urlToImage: item['urlToImage'],
      );
      userModelList.add(articles);
      SearchResult().allResult.add(articles);
    }
    cnt++;
  }
  return userModelList;
}
