import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class ProfileinfoEditViewModel extends AsyncNotifier<void> {
  bool isEditing = false;
  
  @override
  FutureOr<void> build() {}

  Future<void> uploadProfileInfo(String bio, String info) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(usersProvider.notifier).onInfoload(bio, info);
    });
  }

  void setIsEditing(bool value){
    isEditing = value;
    state = AsyncValue.data(isEditing);
  }

  bool getisEditing(){
    return isEditing;
  }
}

final profileInfoProvider =  AsyncNotifierProvider<ProfileinfoEditViewModel, void>(
  () => ProfileinfoEditViewModel(),
);
