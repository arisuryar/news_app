import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class GetHeadlinesSearchUseCase {
  final NewsRepository _newsRepository;

  GetHeadlinesSearchUseCase(this._newsRepository);

  Future<Either<Failure, List<NewsEntity>>> call({required String query}) {
    return _newsRepository.getSearchHeadlines(query);
  }
}
