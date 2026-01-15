import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/models/psalm_loader.dart';
import 'package:psaltir/pages/main_page.dart';
import 'package:psaltir/providers/accessibility_provider.dart';
import 'package:psaltir/providers/bookmarks_provider.dart';
import 'package:psaltir/providers/navigation_provider.dart';
import 'package:psaltir/providers/reading_provider.dart';
import 'package:psaltir/providers/theme_provider.dart';
import 'package:psaltir/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final psalmLoader = PsalmLoader();
  await psalmLoader.preloadData();

  final bookmarksProvider = BookmarksProvider(psalmLoader);
  await bookmarksProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider<PsalmLoader>.value(value: psalmLoader),
        ChangeNotifierProvider(
          create: (context) => ReadingProvider(psalmLoader),
        ),
        ChangeNotifierProvider.value(value: bookmarksProvider),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => AccessibilityProvider()),
      ],
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
      themeMode: themeProvider.themeMode, //uvedi system theme i pokreni prvo s tim
    );
  }
}
