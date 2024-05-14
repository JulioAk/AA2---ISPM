import 'dart:convert';
import 'package:http/http.dart' as http;
import "constructor.dart";

class NewsService {
  static const String _apiKey = 'f6329394047849848373e2a90378c536';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';
  static const String _country = 'us';

  static Future<List<News>> fetchNews() async {
    final client = http.Client();

    final response = await client.get(
      Uri.parse('$_baseUrl?country=$_country&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> articles = data['articles'];
      return articles.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Error al solicitar la información');
    }
  }
}

