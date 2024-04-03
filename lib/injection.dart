import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:news_app/features/authentication/data/remote_data_source/auth_remote_data_source.dart';
import 'package:news_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:news_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:news_app/features/authentication/domain/usecase/auth_status_user_usecase.dart';
import 'package:news_app/features/authentication/domain/usecase/current_user_usecase.dart';

import 'package:news_app/features/authentication/domain/usecase/google_auth_usecase.dart';
import 'package:news_app/features/authentication/domain/usecase/logout_auth_usecase.dart';
import 'package:news_app/features/authentication/presentation/controller/authentication_controller.dart';
import 'package:news_app/features/news/data/datasource/news_remote_data_source.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/usecase/get_headlines_business_use_case.dart';
import 'package:news_app/features/news/domain/usecase/get_headlines_category_use_case.dart';
import 'package:news_app/features/news/domain/usecase/get_headlines_search_use_case.dart';
import 'package:news_app/features/news/domain/usecase/get_top_headlines_news_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/features/news/presentation/controller/home_controller.dart';
import 'package:news_app/features/news/presentation/controller/search_controller.dart';

class DependenciesBindings extends Bindings {
  @override
  void dependencies() {
    // controller
    Get.lazyPut(() => HomeController(Get.find(), Get.find()));
    Get.lazyPut(() => SearchControllerPage(Get.find()));
    Get.lazyPut(() => AuthenticationController());

    // use case
    Get.lazyPut(() => GetTopHeadlinesNewsUseCase(Get.find()));
    Get.lazyPut(() => GetHeadlinesBusinessUseCase(Get.find()));
    Get.lazyPut(() => GetHeadlinesCategoryUseCase(Get.find()));
    Get.lazyPut(() => GetHeadlinesSearchUseCase(Get.find()));

    Get.lazyPut(() => GoogleAuthUseCase(Get.find()));
    Get.lazyPut(() => AuthStatusUserUseCase(Get.find()));
    Get.lazyPut(() => LogoutAuthUseCase(Get.find()));
    Get.lazyPut(() => CurrentUserUseCase(Get.find()));

    // Repositories
    Get.lazyPut<NewsRepository>(() => NewsRepositoryImpl(Get.find()));
    Get.lazyPut<AuthenticationRepository>(() => AuthencticationRepositoryImpl(Get.find(), Get.find()));

    // DataSource
    Get.lazyPut<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());

    // External
    Get.lazyPut(() => http.Client());
    Get.lazyPut(() => FirebaseAuth.instance);
  }
}
