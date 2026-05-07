import 'package:flutter/material.dart';
import '../core/news_api/models/article.dart';
import 'widgets/app_styles.dart';

class NewsDetailView extends StatelessWidget {
  final Article article;

  const NewsDetailView({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasImage = article.urlToImage != null && article.urlToImage!.isNotEmpty;

    return Scaffold(
      backgroundColor: AppStyles.bgWhite,
      appBar: AppBar(
        backgroundColor: AppStyles.bgWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppStyles.primaryRed),
        title: const Text('DETAIL NEWS', style: TextStyle(color: AppStyles.primaryRed, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppStyles.borderGrey, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article.title, style: AppStyles.detailTitle),
            const SizedBox(height: 12),
            Text('${article.source.name} • ${_formatDate(article.publishedAt)}', style: AppStyles.detailTime),
            const SizedBox(height: 16),
            if (article.description != null && article.description!.isNotEmpty) ...[
              Text(article.description!, style: AppStyles.detailDescription),
              const SizedBox(height: 16),
            ],
            if (hasImage) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  article.urlToImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (article.content != null && article.content!.isNotEmpty)
              Text(_cleanContent(article.content!), style: AppStyles.detailContent)
            else
              const Text('Không tải được nội dung chi tiết từ máy chủ.', style: AppStyles.detailContent),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }

  String _cleanContent(String content) {
    return content.replaceAll(RegExp(r'\[\+\d+ chars\]'), '').trim();
  }
}