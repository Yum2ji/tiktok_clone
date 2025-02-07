import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/match_data.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tabbar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        //CustomScrollView를 NestScrollView로 바꿈
        // 사유는 NestScrollView 로 scroll 가능한 widget들을 link 해서 하나로 control 하도록 하기때문문
        child: NestedScrollView(
          //physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                title: const Text("Yumi"),
                actions: [
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
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      foregroundImage: NetworkImage(
                        "https://i.ytimg.com/vi/LYKTtPFB9b4/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBHxhTHbXz0HzU6pp4GLK-98XPQnw",
                      ),
                      child: Text(
                          "Yumi"), //refresh 하면 짧은순간에 이름이 보이는 이런 효과추구하려면 text도 적는게좋을듯
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "@YumiYumi",
                          style: TextStyle(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const MatchData(
                            val: "97",
                            info: "Following",
                          ),
                          VerticalDivider(
                            //specific hegiht을 가진 부모위젯필요
                            width: Sizes.size32, // A|B 가 있을때 A와 B사이의 거리를 의미함
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
                            width: Sizes.size32, // A|B 가 있을때 A와 B사이의 거리를 의미함
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
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.size12,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.all(
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
                                width: 1, color: Colors.grey.shade300),
                          ),
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size10,
                            horizontal: Sizes.size8,
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.youtube,
                            size: Sizes.size24,
                          ),
                        ),
                        Gaps.h10,
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.grey.shade300),
                          ),
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.size32,
                      ),
                      child: Text(
                        "All highlights and where to watch live matches on FIFA+. I wonder wonder",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v14,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size12,
                        ),
                        Gaps.h4,
                        Text(
                          "https://nomadcoder.co",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
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
                itemCount: 20,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //# of columns
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
                          top: Sizes.size96 + Sizes.size96 + Sizes.size4,
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
    );
  }
}
