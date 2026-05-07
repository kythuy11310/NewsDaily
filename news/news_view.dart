import 'package:flutter/material.dart';
import 'news_controller.dart';
import 'news_detail_view.dart';
import 'widgets/news_card.dart';
import 'widgets/vnexpress_header.dart';
import 'widgets/app_styles.dart';

class NewsView extends StatefulWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final NewsController _controller = NewsController();
  final TextEditingController _searchController = TextEditingController();
  
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }


  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _controller.loadNews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.state;

    return Scaffold(
      backgroundColor: AppStyles.bgWhite,
      body: SafeArea(
        child: Column(
          children: [
            VnExpressHeader(
              appLogo: Image.asset(
                'assets/images/app_logo.png', 
                height: 35, 
                fit: BoxFit.contain,
              ),
              onSearchTapped: _toggleSearch,
            ),
            
            if (_isSearching)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: AppStyles.bgNavBar,
                child: Container(
                  decoration: AppStyles.searchBox,
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Nhập từ khóa cần tìm...',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                        onPressed: _toggleSearch,
                      ),
                      border: InputBorder.none, 
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onSubmitted: (value) {
                      _controller.searchArticles(value);
                    },
                  ),
                ),
              ),

            if (_isSearching && !state.isLoading && state.totalResults > 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey[100],
                child: Text(
                  'Tìm thấy ${state.totalResults} kết quả cho "${_searchController.text}"',
                  style: const TextStyle(fontSize: 13, color: AppStyles.primaryRed, fontStyle: FontStyle.italic),
                ),
              ),

            Expanded(
              child: _buildBody(state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppStyles.primaryRed));
    }
    if (state.error.isNotEmpty) {
      return Center(child: Text("Lỗi: ${state.error}", style: AppStyles.articleTitle));
    }
    if (state.articles.isEmpty) {
      return const Center(child: Text("Không có dữ liệu phù hợp", style: AppStyles.articleTitle));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: state.articles.length,
      itemBuilder: (context, index) {
        return NewsCard(
          article: state.articles[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailView(article: state.articles[index]),
              ),
            );
          },
        );
      },
    );
  }
}