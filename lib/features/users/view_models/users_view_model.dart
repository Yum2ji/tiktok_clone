import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersrepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    // await Future.delayed(const Duration(seconds: 10));
    _usersrepository = ref.read(userRepo);
    /*
     로그인 한 후-> refresh 했을 때 정보 날라가는 거 막으려 함.
      return UserProfileModel.empty(); 이렇게 해버리면 UserProfileModel 이 날라가버리므로.
     */
    _authenticationRepository = ref.read(authRepo);
    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersrepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(
      UserCredential credential, String? name, String? birthday) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    //혹시 몰라서 loading 으로 해놓음음. firebase에 저장하는 동안 profile 파일로 widget 자체가 넘어가 버릴 수 잇어서.
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anon@anon.com",
      name: name ?? "undefined",
      bio: "undefined",
      link: "undefined",
      birthday: birthday ?? DateTime.now().toString(),
    );

    await _usersrepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    //여기서는 loading 안함. loading 하면 전체가 loading 되므로

    if (state.value == null) return;
    //값 바꿀 때 copywith를 쓰는게 특징
    //state 값 먼저 바꾸주면-> firebase 변경하는 동안에 미리 widget에 보이는 장점.
    state = AsyncValue.data(state.value!.copyWith(
      hasAvatar: true,
    ));
    await _usersrepository.updateUser(
      state.value!.uid,
      {"hasAvatar": true},
    );
  }

  Future<void> onInfoload(String? newBio, String? newLink) async {
    if (state.value == null) return;
    String bio = newBio ?? state.value!.bio;
    String link = newLink ?? state.value!.link;
    state = AsyncValue.data(state.value!.copyWith(
      bio: bio,
      link: link,
    ));
    await _usersrepository.updateUser(
      state.value!.uid,
      {
        "bio": bio,
        "link": link,
      },
    );
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
