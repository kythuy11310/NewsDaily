import 'package:flutter/material.dart';
import '../../core/news_api/news_api.dart';
import 'app_styles.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const NewsCard({
    Key? key, 
    required this.article, 
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasImage = article.urlToImage != null && article.urlToImage!.isNotEmpty;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: AppStyles.bgWhite,
          border: Border(bottom: BorderSide(color: AppStyles.borderGrey, width: 0.5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: AppStyles.articleTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    if (article.description != null && article.description!.isNotEmpty)
                      Text(
                        article.description!,
                        style: AppStyles.articleDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 6),
                    Text(
                      '${article.source.name} • ${_formatDate(article.publishedAt)}',
                      style: AppStyles.articleMeta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            if (hasImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  article.urlToImage!,
                  width: 110,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(width: 110, height: 80, color: Colors.grey[200], child: const Icon(Icons.error, color: Colors.grey)),
                ),
              )
            else
              Container(width: 110, height: 80, color: Colors.grey[200], child: const Icon(Icons.image, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return '';
    }
  }
}