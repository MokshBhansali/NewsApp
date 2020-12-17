import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/newsModel.dart';

class SearchResult {
  List<Articles> searchResult = [];
  List<Articles> allResult = [];
}

List<Articles> searchValue = [];

getData(int displayData, String country, {var popular}) async {
  String url =
      "http://newsapi.org/v2/top-headlines?country=$country&excludeDomains=stackoverflow.com&sortBy=$popular&apiKey=01999c1172bf48d7a91942e7d1cfb954";
  var result = await http.get(url);
  var objectResult = json.decode(result.body);
  var userModelList = List<Articles>();
  var cnt = 0;

  for (var item in objectResult["articles"]) {
    if (cnt < displayData) {
      Articles articles = Articles.fromJson(item);
      userModelList.add(articles);
      searchValue.add(articles);
    }
    cnt++;
  }
  return userModelList;
}
