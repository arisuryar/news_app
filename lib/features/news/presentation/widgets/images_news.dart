import 'package:flutter/material.dart';

import 'package:news_app/features/news/domain/entities/news_entity.dart';

class ImagesNews extends StatelessWidget {
  const ImagesNews({
    super.key,
    required this.news,
  });

  final NewsEntity news;

  @override
  Widget build(BuildContext context) {
    return news.urlToImage == null
        ? Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 32,
                  color: Colors.grey,
                ),
                SizedBox(height: 4),
                Text(
                  'No Image',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
              ],
            ),
          )
        : Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(news.urlToImage!),
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
