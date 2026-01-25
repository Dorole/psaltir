import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/models/navigation_models.dart';
//import 'package:psaltir/pages/accessibility_page.dart';
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
    AppPage.settings: SettingsPage(),
    AppPage.bookmarks: BookmarksPage(),
    AppPage.reading: ReadingPage(),
  };

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    final currentPage = navProvider.currentPage;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      bottomNavigationBar: _buildCustomBottomNavBar(navProvider, currentPage),
      body: SafeArea(child: _pages[currentPage]!),
      backgroundColor: colorScheme.secondaryContainer,
    );
  }

  Widget _buildCustomBottomNavBar(
    NavigationProvider navProvider,
    AppPage currentPage,
  ) {
    final navItems = const [
      NavItem(Icons.home, AppPage.home),
      NavItem(Icons.bookmark_outline_rounded, AppPage.bookmarks),
      NavItem(Icons.settings, AppPage.settings),
    ];
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final navItem in navItems)
            _buildNavIcon(
              icon: navItem.icon,
              page: navItem.page,
              currentPage: currentPage,
              navProvider: navProvider,
            ),
        ],
      ),
    );
  }

  Widget _buildNavIcon({
    required IconData icon,
    required AppPage page,
    required AppPage currentPage,
    required NavigationProvider navProvider,
  }) {
    final bool isActive = page == currentPage;
    var colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => navProvider.goTo(page),
          icon: Icon(icon),
          iconSize: 30,
          color: isActive ? colorScheme.onSecondaryContainer : Colors.white,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: isActive ? 6 : 4,
          width: isActive ? 6 : 4,
          decoration: BoxDecoration(
            color: isActive
                ? colorScheme.onSecondaryContainer
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class NavItem {
  final IconData icon;
  final AppPage page;
  const NavItem(this.icon, this.page);
}
