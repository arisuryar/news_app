import 'package:get/get.dart';
import 'package:news_app/core/base_state/base_state.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/usecase/get_headlines_category_use_case.dart';
import 'package:news_app/features/news/domain/usecase/get_top_headlines_news_use_case.dart';

class HomeController extends GetxController {
  final GetHeadlinesCategoryUseCase _useCaseCategoryHeadlines;
  final GetTopHeadlinesNewsUseCase _useCaseTopHeadlines;

  Rx<BaseState<List<NewsEntity>>> baseTopHeadlines = BaseState<List<NewsEntity>>().obs;
  Rx<BaseState<List<NewsEntity>>> baseCategory = BaseState<List<NewsEntity>>().obs;

  HomeController(this._useCaseCategoryHeadlines, this._useCaseTopHeadlines);

  final _isSelected = 'business'.obs;
  RxString get selected => _isSelected;
  set selected(RxString n) => _isSelected.value = n.value;

  List<String> category = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  Future<void> topHeadlines() async {
    baseTopHeadlines.value = baseTopHeadlines.value.copyWith(state: StatusState.loading);

    final result = await _useCaseTopHeadlines();

    result.fold(
      (failure) => baseTopHeadlines.value = baseTopHeadlines.value.copyWith(
        state: StatusState.failed,
        message: failure.message,
      ),
      (result) => baseTopHeadlines.value = baseTopHeadlines.value.copyWith(
        state: StatusState.loaded,
        data: result,
      ),
    );
  }

  Future<void> headlinesCategory(String category) async {
    baseCategory.value.data?.clear();
    baseCategory.value = baseCategory.value.copyWith(state: StatusState.loading);

    final result = await _useCaseCategoryHeadlines(category: category);

    result.fold(
      (failure) => baseCategory.value = baseCategory.value.copyWith(
        state: StatusState.failed,
        message: failure.message,
      ),
      (result) => baseCategory.value = baseCategory.value.copyWith(
        state: StatusState.loaded,
        data: result,
      ),
    );
  }
}
