import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/models/navigation_models.dart';
import 'package:psaltir/pages/accessibility_page.dart';
import 'package:psaltir/pages/bookmarks_page.dart';
import 'package:psaltir/pages/home_page.dart';
import 'package:psaltir/pages/reading_page.dart';
import 'package:psaltir/pages/settings_page.dart';
import 'package:psaltir/providers/navigation_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Map<AppPage, Widget> _pages = {
    AppPage.home: HomePage(),
    AppPage.accessibility: AccessibilityPage(),
    AppPage.settings: SettingsPage(),
    AppPage.bookmarks: BookmarksPage(),
    AppPage.reading: ReadingPage(),
    //details page
  };

  static const List<AppPage> _bottomNavBarPages = [
    AppPage.home,
    AppPage.accessibility,
    AppPage.settings,
    AppPage.bookmarks,
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    final currentPage = navProvider.currentPage;

    return Scaffold(
      bottomNavigationBar: _buildBottomNavBar(navProvider, currentPage),
      body: SafeArea(child: _pages[currentPage]!),
      backgroundColor: Colors.amber[50],
    );
  }

  // TO DO: Replace with a row of IconButtons for more control (no highlight on sub-pages)
  // check: https://stackoverflow.com/questions/74165517/bottomnavigationbar-without-highlighted-items-flutter
  BottomNavigationBar _buildBottomNavBar(
    NavigationProvider navProvider,
    AppPage currentPage,
  ) {
    final currentIndex = _bottomNavBarPages.contains(currentPage)
        ? _bottomNavBarPages.indexOf(currentPage)
        : null;

    return BottomNavigationBar(
      currentIndex: currentIndex ?? 0,
      onTap: (index) => navProvider.goTo(_bottomNavBarPages[index]),
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
