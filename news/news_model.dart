import '../core/news_api/news_api.dart';

class NewsModel {
  final List<Article> articles;
  final int totalResults;
  final bool isLoading;
  final String error;

  const NewsModel({
    this.articles = const [],
    this.totalResults = 0,
    this.isLoading = false,
    this.error = '',
  });

  NewsModel copyWith({
    List<Article>? articles,
    int? totalResults,
    bool? isLoading,
    String? error,
  }) {
    return NewsModel(
      articles: articles ?? this.articles,
      totalResults: totalResults ?? this.totalResults,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}