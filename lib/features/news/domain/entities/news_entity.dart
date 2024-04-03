// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  NewsEntity({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props => [author, title, description, url, urlToImage, publishedAt, content];
}
