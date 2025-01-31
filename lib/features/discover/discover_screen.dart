import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final int _selectedPageIndex = 0;
  final TextEditingController _textEditingController = TextEditingController(
    text: "Initial Text",
  );

  void _onSearchChanged(String value) {
    print("Searcch for $value");
  }

  void _onSearchSubmitted(String value) {
    print("Submitted value : $value");
  }

 //키도드 사라지게 할때.  FocusScope.of(context).unfocus(); 를 사용하면 됨.
  void _onTabBarTap(int idx){
    if(_selectedPageIndex != idx) FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        //textfield 같은거로 keyboard 나타나면 공간이 이상해짐
        //resize 못하게 scaffold 에서설정필요
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          //android 는 elevation이 자동으로 생기는듯
          //appBar와 body 사이의 공간에 줄 긋는 것이 ios 는 자동이 아닌듯.
          elevation: 1,
          centerTitle: true,
          //TextFiledstyle이 설정안되었으면 main 에 지정한 defaultstye을 따름름
          title: Row(
            children: [
              Expanded(
                child: CupertinoSearchTextField(
                  controller: _textEditingController,
                  onChanged: _onSearchChanged,
                  onSubmitted: _onSearchSubmitted,
                ),
              ),
              Gaps.h10,
              const FaIcon(FontAwesomeIcons.filter),
            ],
          ),

          //Appbar의 bottom옵션
          // preffered size widget
          // 부모노드는 fixed. but 자식노드는 부모노드의 제한을 받지않음.
          //여기서는 TabBar를 사용하지만,
          //PreferredSize(preferredSize: Size(20, 100), child: ConstrainedBox(constraints: constraints)) ,
          //이런식으로 prefferedsizedwidget이 아님에도, child 에 넣고 size 값 조정해서 사용가능.
          bottom: TabBar(
            onTap: _onTabBarTap,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            //TabBar 사용하려면 controller가 있어야함.
            //따라서 Scaffold 를 DefaultTabController 로 감싸버림
            tabs: [
              for (var tab in tabs) Tab(text: tab),
            ],
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        body: TabBarView(
          children: [
            //.builder를 쓰면 더 좋은 performance를 보임
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size6,
                vertical: Sizes.size6,
              ),
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //# of columns
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,

                //itembuilder쪽으세서 overflow 나면 여기 childAspectRatio를 수정해야함.
                //9 / 16 원래 이값이였는데 height에서 overflow 나서 9/20으로 바꿈.
                childAspectRatio: 9 / 20,
              ),
              //불러오는 image가 모두 사이즈가 다를 것임.비율도 다르고 그래서 ApsecctRatio
              //AspectRatio 쓸때는 자식위젯에서도 fit 하도록 해줘야함.
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      //이미지가 overflow 하면 해다 decoration이 안맞을 수 있음.
                      // 이런경우는 clip을 할것것
                      borderRadius: BorderRadius.circular(
                        Sizes.size4,
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 15,
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
                  ),
                  Gaps.v10,
                  const Text(
                    "This is a very long caption for my tiktok that I'm upload just now currently.",
                    style: TextStyle(
                      fontSize: Sizes.size16 + Sizes.size2,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gaps.v8,
                  //DefaultTextStyle 로 하면 자식노드는 따로 지정하지 않는 한, 같은 style 을 가짐.
                  DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                              "https://i.ytimg.com/vi/LYKTtPFB9b4/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBHxhTHbXz0HzU6pp4GLK-98XPQnw"),
                        ),
                        Gaps.h4,
                        const Expanded(
                          child: Text(
                            "My avatar is going to be very long",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gaps.h4,
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size16,
                          color: Colors.grey.shade600,
                        ),
                        Gaps.h2,
                        const Text(
                          "2.5M",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            for (var tab in tabs.skip(1)) //skip 사용하면 1번 항목 빼고 skip
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
