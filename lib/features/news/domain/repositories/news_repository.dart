import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getTopHeadlinesNews();
  Future<Either<Failure, List<NewsEntity>>> getHeadlinesBusiness();
  Future<Either<Failure, List<NewsEntity>>> getHeadlinesCategory(String category);
  Future<Either<Failure, List<NewsEntity>>> getSearchHeadlines(String query);
}
