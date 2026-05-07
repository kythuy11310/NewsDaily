import 'package:flutter/material.dart';
import '../core/news_api/news_api.dart';
import 'news_model.dart';

class NewsController extends ChangeNotifier {
  final NewsApiClient _apiClient = NewsApiClient();
  NewsModel _state = const NewsModel();

  NewsModel get state => _state;

  NewsController() {
    loadNews();
  }
  Future<void> loadNews() async {
    _state = _state.copyWith(isLoading: true, error: '');
    notifyListeners();

    try {
      final response = await _apiClient.fetchTopHeadlines();
      _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> searchArticles(String query) async {
    if (query.trim().isEmpty) {
      await loadNews();
      return;
    }

    _state = _state.copyWith(isLoading: true, error: '');
    notifyListeners();

    try {
      final response = await _apiClient.searchNews(query);
      _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleResponse(ArticleResponse response) {
    final validArticles = response.articles.where((a) => a.title.isNotEmpty && a.url.isNotEmpty).toList();
    _state = _state.copyWith(
      isLoading: false,
      articles: validArticles,
      totalResults: response.totalResults,
    );
    notifyListeners();
  }

  void _handleError(Object e) {
    _state = _state.copyWith(
      isLoading: false,
      error: e.toString(),
    );
    notifyListeners();
  }
}