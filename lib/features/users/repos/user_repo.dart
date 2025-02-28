import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  /*
    create profile, get profile,
    update avatar, bio, link 
   */

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    //_storage.ref() 이건 firebase에서 storage 에 해당하는 위치
    //.child도 해서 공간을 만듦.
    final fileRef = _storage.ref().child("avatars/$fileName");
    await fileRef.putFile(file);
    /*
    final task = await fileRef.putFile(file);
    task.upload() -> upload/resume 등과 같은 여러 종류의 작업이 가능함.
     */
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
