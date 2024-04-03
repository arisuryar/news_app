import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class GetHeadlinesCategoryUseCase {
  final NewsRepository _newsRepository;

  GetHeadlinesCategoryUseCase(this._newsRepository);

  Future<Either<Failure, List<NewsEntity>>> call({required String category}) {
    return _newsRepository.getHeadlinesCategory(category);
  }
}
