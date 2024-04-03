import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';

// ignore: must_be_immutable
class NewsModel extends Equatable {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  NewsModel({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toMap() => {
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };

  NewsEntity toEntity() => NewsEntity(
        author: author,
        content: content,
        description: description,
        publishedAt: publishedAt,
        title: title,
        url: url,
        urlToImage: urlToImage,
      );

  @override
  List<Object?> get props => [author, title, description, url, urlToImage, publishedAt, content];
}
