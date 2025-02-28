import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/features/users/view_models/avatar_view_model.dart';

class Avatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;

  const Avatar({
    super.key,
    required this.uid,
    required this.name,
    required this.hasAvatar,
  });

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );

    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null :() =>_onAvatarTap(ref),
      child: isLoading
          ? Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator.adaptive(),
            )
          : CircleAvatar(
              radius: 50,
              //&haha=${DateTime.now().toString()} 만큼 추가해서 cache이미지가 남아서 영향주는거 막음
              //cashe 이미지를 1번만 fetching해서 주소를 임의로 바꿈
              //안드로이드에서는 안나타나는데,ios 에서 나타날수도 있으니 일단 반영하기로
              foregroundImage: hasAvatar? NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/nomad-ym-tiktok.firebasestorage.app/o/avatars%2F$uid?alt=media&haha=${DateTime.now().toString()}",
              ): null,
              child:
                  Text(name), //refresh 하면 짧은순간에 이름이 보이는 이런 효과추구하려면 text도 적는게좋을듯
            ),
    );
  }
}
