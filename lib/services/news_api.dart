import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news/models/article.dart';
import 'package:news/models/article_category.dart';

class NewsAPI {
  const NewsAPI();

  static const String baseURL = 'https://newsapi.org/v2';
  static const String apiKey = 'cf8c972fde0a4129a4868d7cf5ced940';

  Future<List<Article>> fetchArticles(ArticleCategory category) async {
    var url = NewsAPI.baseURL;
    url += '/top-headlines';
    url += '?apiKey=$apiKey';
    url += '&language=en';
    url += '&category=${categoryQueryParamValue(category)}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == 'ok') {
        final dynamic articleJSON = json['articles'] ?? [];
        final List<Article> articles = articleJSON.map<Article>((e) => Article.fromJson(e)).toList();
        return articles;
      } else {
        throw Exception(json['message'] ?? 'Failed to load articles');
      }
    } else {
      throw Exception('Failed to load articles (bad response)');
    }
  }

  String categoryQueryParamValue(ArticleCategory category) {
    switch (category) {
      case ArticleCategory.business:
        return 'business';
      case ArticleCategory.entertainment:
        return 'entertainment';
      case ArticleCategory.general:
        return 'general';
      case ArticleCategory.health:
        return 'health';
      case ArticleCategory.science:
        return 'science';
      case ArticleCategory.sports:
        return 'sports';
      case ArticleCategory.technology:
        return 'technology';
      default:
        return 'general';
    }
  }
}