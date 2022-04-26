import 'package:timeago/timeago.dart' as timeago;

class Article {
  final String title;
  final String url;
  final DateTime publishedAt;
  final String source;
  final String? urlToImage;

  Article({
    required this.title,
    required this.url,
    required this.publishedAt,
    required this.source,
    required this.urlToImage,
  });

  String captionText() {
    final formattedPublishedAt =
        timeago.format(publishedAt, locale: 'en_short');
    return "$source $formattedPublishedAt";
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? "",
      url: json['url'] ?? "",
      publishedAt: DateTime.tryParse(json['publishedAt']) ?? DateTime.now(),
      source: json['source']['name'],
      urlToImage: json['urlToImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'publishedAt': publishedAt.toIso8601String(),
      'source': source,
      'urlToImage': urlToImage,
    };
  }
}
