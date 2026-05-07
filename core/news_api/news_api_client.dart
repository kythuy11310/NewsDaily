import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/models.dart';

class NewsApiClient {
  final String _apiKey = '248fb002ea004756a3b7f56ac366008c'; 

  final String _baseUrlTop = 'https://newsapi.org/v2/top-headlines';
  final String _baseUrlSearch = 'https://newsapi.org/v2/everything';

  Future<ArticleResponse> fetchTopHeadlines() async {
    final url = Uri.parse('$_baseUrlTop?country=us&apiKey=$_apiKey');
    return _getData(url);
  }

  Future<ArticleResponse> searchNews(String query) async {
    final url = Uri.parse('$_baseUrlSearch?q=$query&apiKey=$_apiKey');
    return _getData(url);
  }

  Future<ArticleResponse> _getData(Uri url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ArticleResponse.fromJson(json);
    } else {
      throw Exception('Lỗi khi tải dữ liệu từ máy chủ');
    }
  }
}
