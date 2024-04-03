import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/data/datasource/news_remote_data_source.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _newsRemoteDataSource;

  NewsRepositoryImpl(this._newsRemoteDataSource);
  @override
  Future<Either<Failure, List<NewsEntity>>> getHeadlinesBusiness() async {
    try {
      final result = await _newsRemoteDataSource.fetchHeadlinesBusiness();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Gagal Memuat Berita'));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getHeadlinesCategory(String category) async {
    try {
      final result = await _newsRemoteDataSource.fetchHeadlinesCategory(category);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Gagal Memuat Berita'));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getSearchHeadlines(String query) async {
    try {
      final result = await _newsRemoteDataSource.fetchSearchHeadlines(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Gagal Memuat Berita'));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getTopHeadlinesNews() async {
    try {
      final result = await _newsRemoteDataSource.fetchTopHeadlinesNews();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Gagal Memuat Berita'));
    }
  }
}
