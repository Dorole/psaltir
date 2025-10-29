import 'package:flutter/material.dart';
import 'package:psaltir/pages/accessibility_page.dart';
import 'package:psaltir/pages/bookmarks_page.dart';
import 'package:psaltir/pages/home_page.dart';
import 'package:psaltir/pages/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    AccessibilityPage(),
    SettingsPage(),
    BookmarksPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(child: _pages[_selectedIndex]),
      backgroundColor: Colors.amber[50],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.brown[400],
      iconSize: 30,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "",
          backgroundColor: Colors.brown[200],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_accessibility_rounded),
          label: "",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline_rounded),
          label: "",
        ),
      ],
    );
  }
}
