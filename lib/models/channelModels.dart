class ChannelModels {
  String status;
  List<NewsSources> sources;

  ChannelModels({this.status, this.sources});

  ChannelModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['sources'] != null) {
      sources = new List<NewsSources>();
      json['sources'].forEach((v) {
        sources.add(new NewsSources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.sources != null) {
      data['sources'] = this.sources.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsSources {
  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  NewsSources(
      {this.id,
      this.name,
      this.description,
      this.url,
      this.category,
      this.language,
      this.country});

  NewsSources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    category = json['category'];
    language = json['language'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['url'] = this.url;
    data['category'] = this.category;
    data['language'] = this.language;
    data['country'] = this.country;
    return data;
  }
}
