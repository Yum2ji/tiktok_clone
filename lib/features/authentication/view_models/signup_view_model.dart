import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/utils.dart';

/*
loading 정도만 할 거라서 value 필요없도록 만듦.
 */
class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _autoRepo;

  @override
  FutureOr<void> build() {
    _autoRepo = ref.read(authRepo);
  }

/*
계정생성에 필요한 정보를 다 넣은 경우에 사용
 */
  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);
    //아래 2줄 또는 AsyncValue.gaurd로 입력 에러생기면 에러값을 입력 아니면 future에 값을 입력해줌.
    //await _autoRepo.signUp(form["email"], form["password"]);
    //state = AsyncValue.data(null);
    state = await AsyncValue.guard(() async {
      final userCredential = await _autoRepo.emailSignUp(
        form["email"],
        form["password"],
      );
      print(form["name"]);
      print(form["birthday"]);
      await users.createProfile(
        userCredential,
        form['name'],
        form['birthday'],
      );
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(InterestsScreen.routeName);
    }
  }
}

/*
signUpForm user가 정보를 잘 적는지 체크
 */
final signUpForm = StateProvider(
  (ref) => {},
);

/*

 */
final signupProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
