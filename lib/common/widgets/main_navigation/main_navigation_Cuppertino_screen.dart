import 'package:flutter/cupertino.dart';

class MainNavigationCuppertinoScreen extends StatefulWidget {
  const MainNavigationCuppertinoScreen({super.key});

  @override
  State<MainNavigationCuppertinoScreen> createState() => _MainNavigationCuppertinoScreenState();
}

class _MainNavigationCuppertinoScreenState extends State<MainNavigationCuppertinoScreen> {
  final screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    ),
  ];

  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }




  // MainNavigationCuppertinoBarScreen
  // CupertinoTabBar 는 ios 스타일의 navigationbar 만들때
  // 단, BottomNavigationBarItem으로, icon 넣을 때는 ios 향 icon인 cupertinoIcons를 사용
  // setstae를 할 필요가 없는.
  // 단, main.dart 에서는 MaterialApp으로 하지 않고, 
  //// CupertinoApp 으로 하면 scaffold 의 body는 빨간글씨 노란 밑줄 없음


  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.house,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.search,
            ),
            label: "Search",
          ),
        ],
      ),
      tabBuilder: (context, index) => screens[index],
    );
  }
}
