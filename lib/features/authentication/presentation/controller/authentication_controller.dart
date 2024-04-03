import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:news_app/core/base_state/base_state.dart';
import 'package:news_app/features/authentication/domain/usecase/auth_status_user_usecase.dart';
import 'package:news_app/features/authentication/domain/usecase/current_user_usecase.dart';

import 'package:news_app/features/authentication/domain/usecase/google_auth_usecase.dart';
import 'package:news_app/features/authentication/domain/usecase/logout_auth_usecase.dart';

class AuthenticationController extends GetxController {
  final GoogleAuthUseCase _googleAuth = Get.find();
  final LogoutAuthUseCase _logoutAuthUseCase = Get.find();
  final AuthStatusUserUseCase _authStatusUserUseCase = Get.find();
  final CurrentUserUseCase _currentUserUseCase = Get.find();

  Rx<BaseState<User>> baseAuth = BaseState<User>().obs;

  Stream<User?> get userStatus => _authStatusUserUseCase();
  User get currentUsers => _currentUserUseCase();

  Future<void> get logout => _logoutAuthUseCase();

  Future<void> authGoogle() async {
    baseAuth.value = baseAuth.value.copyWith(state: StatusState.loading);

    final result = await _googleAuth();

    result.fold(
      (failure) => baseAuth.value = baseAuth.value.copyWith(
        state: StatusState.failed,
        message: failure.message,
      ),
      (result) => baseAuth.value = baseAuth.value.copyWith(
        state: StatusState.loaded,
        data: result,
      ),
    );
  }
}
