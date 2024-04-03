import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class GetHeadlinesBusinessUseCase {
  final NewsRepository _newsRepository;

  GetHeadlinesBusinessUseCase(this._newsRepository);

  Future<Either<Failure, List<NewsEntity>>> call() {
    return _newsRepository.getHeadlinesBusiness();
  }
}
