import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo);
  }

  //uploadAvatar 자체가 이미 로그인했을때나만 가능한것이므로
  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();

    //이건 storage에 저장
    final fileName = ref.read(authRepo).user!.uid;

    //이건 user라는 collection firebase에 저장하는 거 users_view_model에 있는는
    state = await AsyncValue.guard(() async {
      await _repository.uploadAvatar(
        file,
        fileName,
      );
      await ref.read(usersProvider.notifier).onAvatarUpload();
    });

  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
