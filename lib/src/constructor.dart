// lib/news_model.dart
class News {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String source;

  News({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.source,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      source: json['source']['name'] ?? '',
    );
  }
}
