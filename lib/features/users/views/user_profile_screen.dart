import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoint.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/view_models/profileInfo_edit_view_model.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/views/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/views/widgets/profileinfo.dart';
import 'package:tiktok_clone/features/users/views/widgets/match_data.dart';
import 'package:tiktok_clone/features/users/views/widgets/persistent_tabbar.dart';
import 'package:tiktok_clone/utils.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  //final String tab;
  const UserProfileScreen({
    super.key,
    required this.username,
    // required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onInfoUploadTap(WidgetRef ref) {
     ref.read(profileInfoProvider.notifier).setIsEditing(true);
  }

  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text("$error"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                //initialIndex: widget.tab == "likes"? 1 : 0,
                length: 2,
                //CustomScrollView를 NestScrollView로 바꿈
                // 사유는 NestScrollView 로 scroll 가능한 widget들을 link 해서 하나로 control 하도록 하기때문문
                child: NestedScrollView(
                  //physics: const BouncingScrollPhysics(),
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        centerTitle: true,
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: () => _onInfoUploadTap(ref),
                            icon: const FaIcon(
                              FontAwesomeIcons.pen,
                              size: Sizes.size20,
                            ),
                          ),
                          IconButton(
                            onPressed: _onGearPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.gear,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        //SliverToBoxAdpater 안에는 자식노드의 자식노드의 자식노드에도 sliver는 사용못함
                        child: width > Breakpoints.md
                            ? SizedBox(
                                width: Breakpoints.sm * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Gaps.v20,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Gaps.v20,
                                        Column(
                                          children: [
                                            Avatar(
                                              uid: data.uid,
                                              name: data.name,
                                              hasAvatar: data.hasAvatar,
                                            ),
                                            Gaps.v20,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "@${data.name}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: Sizes.size18,
                                                  ),
                                                ),
                                                Gaps.h5,
                                                FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCircleCheck,
                                                  size: Sizes.size16,
                                                  color: Colors.blue.shade500,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Gaps.h24,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: Sizes.size52,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const MatchData(
                                                    val: "97",
                                                    info: "Following",
                                                  ),
                                                  VerticalDivider(
                                                    //specific hegiht을 가진 부모위젯필요
                                                    width: Sizes
                                                        .size32, // A|B 가 있을때 A와 B사이의 거리를 의미함
                                                    thickness: Sizes.size1,
                                                    color: Colors.grey.shade400,
                                                    indent: Sizes.size14,
                                                    endIndent: Sizes.size14,
                                                  ),
                                                  const MatchData(
                                                    val: "10 M",
                                                    info: "Followers",
                                                  ),
                                                  VerticalDivider(
                                                    //specific hegiht을 가진 부모위젯필요
                                                    width: Sizes
                                                        .size32, // A|B 가 있을때 A와 B사이의 거리를 의미함
                                                    thickness: Sizes.size1,
                                                    color: Colors.grey.shade400,
                                                    indent: Sizes.size14,
                                                    endIndent: Sizes.size14,
                                                  ),
                                                  const MatchData(
                                                    val: "194.3M",
                                                    info: "Likes",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Gaps.v14,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  //FractionallySizedBox
                                                  //width, heigth 은 부모노드 기준
                                                  // widthFactor: 0.33,
                                                  width: width > Breakpoints.sm
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.16
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.3,
                                                  height: width > Breakpoints.sm
                                                      ? Breakpoints.sm * 0.07
                                                      : width * 0.03,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: Sizes.size12,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(
                                                            Sizes.size4),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Follow",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                Gaps.h10,
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors
                                                            .grey.shade300),
                                                  ),
                                                  width: width > Breakpoints.sm
                                                      ? Breakpoints.sm * 0.07
                                                      : width * 0.03,
                                                  height: width > Breakpoints.sm
                                                      ? Breakpoints.sm * 0.07
                                                      : width * 0.03,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: Sizes.size10,
                                                    horizontal: Sizes.size8,
                                                  ),
                                                  child: const Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons.youtube,
                                                      size: Sizes.size24,
                                                    ),
                                                  ),
                                                ),
                                                Gaps.h10,
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors
                                                            .grey.shade300),
                                                  ),
                                                  width: width > Breakpoints.sm
                                                      ? Breakpoints.sm * 0.07
                                                      : width * 0.03,
                                                  height: width > Breakpoints.sm
                                                      ? Breakpoints.sm * 0.07
                                                      : width * 0.03,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: Sizes.size6,
                                                    horizontal: Sizes.size6,
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    size: Sizes.size32,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: Breakpoints.sm * 0.75,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Gaps.v14,
                                            ProfileInfo(
                                              bio: data.bio??"hi",
                                              link: data.link??"http",
                                            ),
                                            Gaps.v20,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Gaps.v20,
                                  Avatar(
                                    uid: data.uid,
                                    name: data.name,
                                    hasAvatar: data.hasAvatar,
                                  ),
                                  Gaps.v20,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "@${data.name}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.h5,
                                      FaIcon(
                                        FontAwesomeIcons.solidCircleCheck,
                                        size: Sizes.size16,
                                        color: Colors.blue.shade500,
                                      ),
                                    ],
                                  ),
                                  Gaps.v24,
                                  SizedBox(
                                    height: Sizes.size52,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const MatchData(
                                          val: "97",
                                          info: "Following",
                                        ),
                                        VerticalDivider(
                                          //specific hegiht을 가진 부모위젯필요
                                          width: Sizes
                                              .size32, // A|B 가 있을때 A와 B사이의 거리를 의미함
                                          thickness: Sizes.size1,
                                          color: Colors.grey.shade400,
                                          indent: Sizes.size14,
                                          endIndent: Sizes.size14,
                                        ),
                                        const MatchData(
                                          val: "10 M",
                                          info: "Followers",
                                        ),
                                        VerticalDivider(
                                          //specific hegiht을 가진 부모위젯필요
                                          width: Sizes
                                              .size32, // A|B 가 있을때 A와 B사이의 거리를 의미함
                                          thickness: Sizes.size1,
                                          color: Colors.grey.shade400,
                                          indent: Sizes.size14,
                                          endIndent: Sizes.size14,
                                        ),
                                        const MatchData(
                                          val: "194.3M",
                                          info: "Likes",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gaps.v14,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        //FractionallySizedBox
                                        //width, heigth 은 부모노드 기준
                                        // widthFactor: 0.33,
                                        width: width > Breakpoints.sm
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.16
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                        height: width > Breakpoints.sm
                                            ? Breakpoints.sm * 0.07
                                            : width * 0.09,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: Sizes.size12,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(Sizes.size4),
                                            ),
                                          ),
                                          child: const Text(
                                            "Follow",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Gaps.h10,
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                        ),
                                        width: width > Breakpoints.sm
                                            ? Breakpoints.sm * 0.07
                                            : width * 0.1,
                                        height: width > Breakpoints.sm
                                            ? Breakpoints.sm * 0.07
                                            : width * 0.1,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Sizes.size10,
                                          horizontal: Sizes.size8,
                                        ),
                                        child: const Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.youtube,
                                            size: Sizes.size24,
                                          ),
                                        ),
                                      ),
                                      Gaps.h10,
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                        ),
                                        width: width > Breakpoints.sm
                                            ? Breakpoints.sm * 0.07
                                            : width * 0.1,
                                        height: width > Breakpoints.sm
                                            ? Breakpoints.sm * 0.07
                                            : width * 0.1,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Sizes.size6,
                                          horizontal: Sizes.size6,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_drop_down_outlined,
                                          size: Sizes.size32,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gaps.v14,
                                  ProfileInfo(
                                    bio: data.bio ?? "hi",
                                    link: data.link ?? "http",
                                  ),
                                  Gaps.v20,
                                ],
                              ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistentTabbar(),
                        pinned: true,
                      ),
                    ];
                  },
                  //CustomScrollView를 쓸때는 TabBArView도 appBar쪽에 있었는데 body로 빼냄.

                  body: TabBarView(
                    //SliverToBoxAdapter 쪽에 쓰였을 때는 TabBarView는 height 이 규정되어야 한다해서 여기는 SizedBox안에들어감
                    //이제 NestedScrollView 사용하니까 Sized 제한 없어서 GridView아래있는 것도 scroll 가능능
                    children: [
                      GridView.builder(
                        //CustomScrollView 부모위젯도 scroll하는데.. GridView=도 scroll가능한 특성.
                        //너무 복잡. 자식노드의 scroll은 physics로 못하게 만들어서 부모위젯 하나로 통제가능핟로고함.
                        physics: const NeverScrollableScrollPhysics(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 100,
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              width > Breakpoints.lg ? 5 : 3, //# of columns
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,

                          //itembuilder쪽으세서 overflow 나면 여기 childAspectRatio를 수정해야함.
                          //9 / 16 원래 이값이였는데 height에서 overflow 나서 9/20으로 바꿈.
                          childAspectRatio: 9 / 14,
                        ),
                        //불러오는 image가 모두 사이즈가 다를 것임.비율도 다르고 그래서 ApsecctRatio
                        //AspectRatio 쓸때는 자식위젯에서도 fit 하도록 해줘야함.
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 14,
                                  //Image.network 를 사용하면 image 불러오는데 시간 걸릴수도 image size 및 network issue
                                  //FadeInImage 사용이유
                                  child: FadeInImage.assetNetwork(
                                    placeholderFit: BoxFit.cover,
                                    placeholder: "assets/images/image2.jpg",
                                    fit: BoxFit.cover, //cover는 공간을 다 덮는
                                    image:
                                        "https://images.unsplash.com/photo-1738251198850-39ba48c75fde?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                  ),
                                ),
                                Positioned(
                                  top:
                                      Sizes.size96 + Sizes.size96 + Sizes.size4,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.play_arrow_outlined,
                                        size: Sizes.size28,
                                        color: Colors.white,
                                      ),
                                      Gaps.h5,
                                      Text(
                                        "$index M",
                                        style: const TextStyle(
                                          fontSize: Sizes.size16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text("Page2"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
