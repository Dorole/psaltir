import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/app_providers.dart';
import 'package:psaltir/services/app_prefs.dart';
import 'package:psaltir/services/bookmarks_store.dart';
import 'package:psaltir/services/psalm_loader.dart';
import 'package:psaltir/pages/main_page.dart';
import 'package:psaltir/providers/bookmarks_provider.dart';
import 'package:psaltir/providers/theme_provider.dart';
import 'package:psaltir/services/settings_store.dart';
import 'package:psaltir/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final appPrefs = AppPrefs(prefs);
  final bookmarksStore = BookmarksStore(appPrefs);
  final settingsStore = SettingsStore(appPrefs);

  final psalmLoader = PsalmLoader();
  await psalmLoader.preloadData();

  final bookmarksProvider = BookmarksProvider(bookmarksStore, psalmLoader);
  await bookmarksProvider.init();

  runApp(
    AppProviders(
      settingsStore: settingsStore,
      psalmLoader: psalmLoader,
      bookmarksProvider: bookmarksProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}
