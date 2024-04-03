import 'dart:convert';

import 'package:news_app/core/api/urls.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> fetchTopHeadlinesNews();
  Future<List<NewsModel>> fetchHeadlinesBusiness();
  Future<List<NewsModel>> fetchHeadlinesCategory(String category);
  Future<List<NewsModel>> fetchSearchHeadlines(String query);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl(this.client);

  @override
  Future<List<NewsModel>> fetchHeadlinesBusiness() async {
    Uri url = Uri.parse('${baseUrl}top-headlines?category=business&country=$country&apiKey=$apiKey');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body)['articles'];
      final listNews = list.map((e) => NewsModel.fromMap(e)).toList();

      return listNews;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NewsModel>> fetchHeadlinesCategory(String category) async {
    Uri url = Uri.parse('${baseUrl}top-headlines?category=$category&country=$country&apiKey=$apiKey');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body)['articles'];
      final listNews = list.map((e) => NewsModel.fromMap(e)).toList();

      return listNews;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NewsModel>> fetchSearchHeadlines(String query) async {
    Uri url = Uri.parse('${baseUrl}everything?q=$query&page=1&apiKey=$apiKey');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body)['articles'];
      final listNews = list.map((e) => NewsModel.fromMap(e)).toList();

      return listNews;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NewsModel>> fetchTopHeadlinesNews() async {
    Uri url = Uri.parse('${baseUrl}top-headlines?country=$country&apiKey=$apiKey');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body)['articles'];
      final listNews = list.map((e) => NewsModel.fromMap(e)).toList();

      return listNews;
    } else {
      throw ServerException();
    }
  }
}
