import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';


//Tutorial 예시-- 가로로 옮길거면 아래코드
//// Swipe 하는걸로 할거면 (fadin 느낌)
class TutorialTabControllScreen extends StatefulWidget {
  const TutorialTabControllScreen({super.key});

  @override
  State<TutorialTabControllScreen> createState() => _TutorialTabControllScreenState();
}

class _TutorialTabControllScreenState extends State<TutorialTabControllScreen> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const SafeArea(
          child: TabBarView(
            //TabBarView는 controller 를 required 하는데, 여기에서 property 선언해도 되지만
            // Scaffold(부모위젯)을 DefaultTabController 로 감쌀수도있음.
           // DefaultTabBar 사용하면 옆으로 왔다갔할 수 있고 Padding 3개 놓을거라고 length 값을 줌.
           children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.size24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v52,
                    Text(
                      "Watch cool videos!",
                      style: TextStyle(
                        fontSize: Sizes.size44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      "Videos are personalized for you based on what you watch, like, and share.",
                      style: TextStyle(
                        fontSize: Sizes.size20 + Sizes.size2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.size24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v52,
                    Text(
                      "Follow the rule!",
                      style: TextStyle(
                        fontSize: Sizes.size44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      "Videos are personalized for you based on what you watch, like, and share.",
                      style: TextStyle(
                        fontSize: Sizes.size20 + Sizes.size2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.size24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v52,
                    Text(
                      "Enjoy the ride",
                      style: TextStyle(
                        fontSize: Sizes.size44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      "Videos are personalized for you based on what you watch, like, and share.",
                      style: TextStyle(
                        fontSize: Sizes.size20 + Sizes.size2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        //bottomNavigator에 TabPageSelector 로 TabBarView 갯수 등 어디인지 알게해줌.
        bottomNavigationBar: BottomAppBar(
          color : Colors.white,
          elevation: 1,
          height : 100,
          child : Container(
            padding:  const EdgeInsets.symmetric(
              vertical : Sizes.size8,
            ),
            child : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabPageSelector(
                  color: Colors.white,
                  selectedColor: Colors.black38,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
