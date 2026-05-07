import 'article.dart';

class ArticleResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  const ArticleResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    final list = json['articles'] as List<dynamic>? ?? [];

    return ArticleResponse(
      status: json['status'] as String? ?? '',
      totalResults: json['totalResults'] as int? ?? 0,
      articles: list
          .map((item) => Article.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
