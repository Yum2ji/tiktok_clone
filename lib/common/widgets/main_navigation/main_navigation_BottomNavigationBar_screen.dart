import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationBottomNaviScreen extends StatefulWidget {
  const MainNavigationBottomNaviScreen({super.key});

  @override
  State<MainNavigationBottomNaviScreen> createState() => _MainNavigationBottomNaviScreenScreenState();
}

class _MainNavigationBottomNaviScreenScreenState extends State<MainNavigationBottomNaviScreen> {
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

  // MainNavigationBottomNaviScreen
  // 여기서는 MainNavigationBottom 쓰는
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: _onTap,
        currentIndex: _selectedIndex,
        //selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: "Home",
            tooltip: "What are you?",
            //background color는 BottomNavigationBar
            // 선택된 값의 background  단 4개이상의 페이질 때만 그럼.
            // 그 이하일 때는 BottomNavigationBarItem의 type : BottomNavigatinBarType.shifting으로 쇼앙앙

            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
            label: "Search",
            tooltip: "What are you?",
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
