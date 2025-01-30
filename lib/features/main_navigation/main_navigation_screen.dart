import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  //screens[_selectedIndex]로 showing 하도록 만들때  주의 필요1.
  //stateful widget을 사용자가 직접만들어 사용할 때,
  //서로 다른 instance임에도, global variables 을 공통으로 인지할 수 있음.
  // Home tab, Discovery tab, Search tab 등 다른 screen임에도 변수가 같은 값을 가질 수 있음.
  // 그래서 key:GlobalKey() 를 주는 것이 좋음음

  // screens[_selectedIndex] 로 showing 하도록 만들때 주의 필요2.
  // screen[_selectedIndex]로 페이지를 보여주고만 있어서
  // 내부 값을 초기화함//다시 빌드함.
  // feed 에서 내가 어디 남아져 있었는지 알고 있어야함.
  // state가 없는 widget이면 어쩔 수 없지만 state가 있다면 place hold 하도록
  // 이는 body->screens[_selectedIndex] 로 showing하는 방식
  // 한 번에 1페이지 보이는 방식을바꾸도록
  // 즉 rendering everyscreen in screens but display only one screen
  //Stack으로 Offstate widget여러개 구현하면 screens 변수도 필요X.
  //Offstate 위젯 내부에 offstage property로

  // final screens = [
  //    StfScreen(
  //     key: GlobalKey(),
  //   ),
  //    StfScreen(
  //     key: GlobalKey(),
  //   ),
  //   const Center(
  //     child: Text('2'),
  //   ),
  //    StfScreen(
  //     key: GlobalKey(),
  //   ),
  //    StfScreen(
  //     key: GlobalKey(),
  //   ),
  // ];

  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
        
          appBar: AppBar(
            title : const Text("Record Vedio",),
            centerTitle: true,
            ),
        ),
        fullscreenDialog :true, //covering whole page
      ),
    );
  }

  // MainNavigationBottomNaviScreen
  // 여기서는 MainNavigationBottom 쓰는

  //MainNavigationMaterialScreen
  //https://m3.material.io/ 에있는 부분과 비슷하면서도 다른.
  //https://m3.material.io/ 는 NavigationBar를 쓰고 설명에 Material 3라고 되어있음.

  // MainNavigationCuppertinoBarScreen
  // CupertinoTabBar 는 ios 스타일의 navigationbar 만들때
  // 단, BottomNavigationBarItem으로, icon 넣을 때는 ios 향 icon인 cupertinoIcons를 사용
  // setstae를 할 필요가 없는.
  // 단, main.dart 에서는 MaterialApp으로 하지 않고,
  //// CupertinoApp 으로 하면 scaffold 의 body는 빨간글씨 노란 밑줄 없음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedIndex==0? Colors.black: Colors.white,
      body: Stack(
        children: [
          //build 되지만 visually hide.
          //Offstage widget이 너무많으면,, consume a lot of resource -> slow
          Offstage(
            offstage: _selectedIndex != 0,
            child:  const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child:  Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child:  Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child:  Container(),
          ),
        ],
      ), // screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                seledtedIcon: FontAwesomeIcons.house,
                icon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: "Discover",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                seledtedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                child: const PostVideoButton(),
              ),
              Gaps.h24,
              NavTab(
                text: "Inbox",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                seledtedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
              ),
              NavTab(
                text: "Profile",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                seledtedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
