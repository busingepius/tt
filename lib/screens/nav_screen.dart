import 'package:flutter/material.dart';
import 'package:plant/screens/plant_editor.dart';

import 'screens.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    const HomeScreen(key: PageStorageKey('homeScreen')),
    const AddEditPlantPage(),
    const MyPlants(),
  ];

  int _currentIndex = 0;

  final Map<String, IconData> _icons = {
    'Home': Icons.home,
    'Add': Icons.add,
    'My Plants': Icons.grass,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        // backgroundColor: const Color(0xFFF3F5F7),
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        onTap: (int index) => setState(() => _currentIndex = index),
        unselectedItemColor: Colors.black,
        items: _icons
            .map((title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(icon, size: 30.0),
                  label: title,
                )))
            .values
            .toList(),
      ),
    );
  }
}
