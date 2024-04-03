import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/base_state/base_state.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/usecase/get_headlines_search_use_case.dart';

class SearchControllerPage extends GetxController {
  final GetHeadlinesSearchUseCase _useCase;

  Rx<BaseState<List<NewsEntity>>> baseSearch = BaseState<List<NewsEntity>>().obs;

  SearchControllerPage(this._useCase);

  TextEditingController searchC = TextEditingController();

  Future<void> headlinesSearch() async {
    baseSearch.value.data?.clear();
    baseSearch.value = baseSearch.value.copyWith(state: StatusState.loading);

    final result = await _useCase(query: searchC.text);

    result.fold(
      (failure) => baseSearch.value = baseSearch.value.copyWith(
        state: StatusState.failed,
        message: failure.message,
      ),
      (result) => baseSearch.value = baseSearch.value.copyWith(
        state: StatusState.loaded,
        data: result,
      ),
    );
  }
}
