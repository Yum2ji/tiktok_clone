import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationMaterialScreen extends StatefulWidget {
  const MainNavigationMaterialScreen({super.key});

  @override
  State<MainNavigationMaterialScreen> createState() => _MainNavigationMaterialScreenState();
}

class _MainNavigationMaterialScreenState extends State<MainNavigationMaterialScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      //https://m3.material.io/ 에있는 부분과 비슷하면서도 다른.
      //https://m3.material.io/ 는 NavigationBar를 쓰고 설명에 Material 3라고 되어있음.
      bottomNavigationBar: NavigationBar(
        labelBehavior : NavigationDestinationLabelBehavior.onlyShowSelected,
         
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.teal,
            ),
            label: 'Home',
          ),
          NavigationDestination(
              icon: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.amber,
              ),
              label: 'Search'),
        ],
        
      ),
    );
  }
}
