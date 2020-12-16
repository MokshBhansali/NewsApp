class PassArguments {
  final String title;
  final String image;
  final String description;
  final String url;
  final String newsSource;
  final String content;
  final String date;
  PassArguments({
    this.title,
    this.url,
    this.newsSource,
    this.image,
    this.description,
    this.content,
    this.date,
  });
}

class NewsChannelName {
  String name;
  String description;
  String url;
  NewsChannelName({this.name, this.description, this.url});
}
