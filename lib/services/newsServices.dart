import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/newsModel.dart';

class SearchResult {
  List<Articles> searchResult = [];
  List<Articles> allResult = [];
}

List<Articles> searchValue = [];

getData(int displayData, String country) async {
  String url =
      "http://newsapi.org/v2/top-headlines?&sortBy=popularity&country=$country&category=business&apiKey=d2d02e1c894c47beaa437c11509324d7";
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
