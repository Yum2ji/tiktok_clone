import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/view_models/profileInfo_edit_view_model.dart';

class ProfileInfo extends ConsumerWidget {
  final String bio;
  final String link;

  ProfileInfo({
    super.key,
    required this.bio,
    required this.link,
  });

  TextEditingController bioController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  @override
  void initState() {
    bioController.text = bio;
    linkController.text = link;
  }

  @override
  void dispose() {
    bioController.dispose();
    linkController.dispose();
  }

  Future<void> _onSaveInfoTap(WidgetRef ref) async {
    ref.read(profileInfoProvider.notifier).setIsEditing(false);
    await ref
        .read(profileInfoProvider.notifier)
        .uploadProfileInfo(bioController.text, linkController.text);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    bool isEditing = ref.watch(profileInfoProvider.notifier).getisEditing();
    return ref.watch(profileInfoProvider).when(
          error: (error, stackTrace) => Center(
            child: Text("$error"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Column(
            children: [
              isEditing
                  ? SizedBox(
                      width: width * 0.55,
                      child: TextField(
                        controller: bioController,
                        decoration: InputDecoration(labelText: bio),
                        onChanged: (value) {},
                      ),
                    )
                  : Text(
                      bio,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              Gaps.v8,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.link,
                    size: Sizes.size12,
                    color: Colors.blue,
                  ),
                  Gaps.h4,
                  isEditing
                      ? SizedBox(
                          width: width * 0.55,
                          child: TextField(
                            controller: linkController,
                            decoration: InputDecoration(labelText: link),
                            onChanged: (value) {},
                          ),
                        )
                      : Text(
                          link,
                          style: const TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue),
                        ),
                ],
              ),
              if (isEditing)
                Column(
                  children: [
                    Gaps.v20,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _onSaveInfoTap(ref),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.size10,
                              horizontal: Sizes.size20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Gaps.h10,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size10,
                            horizontal: Sizes.size20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );
  }
}
