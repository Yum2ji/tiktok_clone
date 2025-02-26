import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_timeline_screen.dart';
import 'package:tiktok_clone/router.dart';
import 'package:tiktok_clone/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";
  final String tab;
  const MainNavigationScreen({super.key, required this.tab});

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


  final List<String> _tabs = [
    "home",
    "discover",
    "xxxx",
    "inbox",
    "profile",
  ];

  /*
   flutter 프로젝트 자체적으로 처음시작되는 페이지가 video이면서
   video 에 음성이 포함되고 있으면 무조건 에러 남.
   chrome, edge 같은데서 소리나는 비디오파일이 첫화면으로 자동재생되는 것을 막음.
  */
 
  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
/*     Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              "Record Vedio",
            ),
            centerTitle: true,
          ),
        ),
        fullscreenDialog: true, //covering whole page
      ),
    ); */

    context.pushNamed(VideoRecordingScreen.routeName);
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
    final isDark = isDarkMode(context);
    return Scaffold(
      //resizeToAvoidBottomInset : bottomNaviagation 같은 것에 의해 생겨서, 키보드가 생기면 화면 resizing이 됨. 해당 현상을 막으려함.
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          //build 되지만 visually hide.
          //Offstage widget이 너무많으면,, consume a lot of resource -> slow
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "Yumi",
              // tab: "",
            ),
          ),
        ],
      ), // screens.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size32,
            top: Sizes.size16,
          ),
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
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Discover",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                seledtedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                child: PostVideoButton(
                  inverted: _selectedIndex == 0,
                ),
              ),
              Gaps.h24,
              NavTab(
                text: "Inbox",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                seledtedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Profile",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                seledtedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
