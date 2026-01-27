import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/accessibility_provider.dart';
import 'package:psaltir/providers/bookmarks_provider.dart';
import 'package:psaltir/providers/navigation_provider.dart';
import 'package:psaltir/providers/reading_provider.dart';
import 'package:psaltir/providers/theme_provider.dart';
import 'package:psaltir/services/psalm_loader.dart';
import 'package:psaltir/services/settings_store.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key, 
    required this.settingsStore, 
    required this.psalmLoader, 
    required this.bookmarksProvider, 
    required this.child, 
    });

  final SettingsStore settingsStore; 
  final PsalmLoader psalmLoader;
  final BookmarksProvider bookmarksProvider;
  final Widget child;
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(settingsStore)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => TextSettingsProvider(settingsStore)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReadingProvider(psalmLoader),
        ),
        ChangeNotifierProvider.value(value: bookmarksProvider),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: child,);
  }
}