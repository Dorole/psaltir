import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/models/psalm_loader.dart';
import 'package:psaltir/pages/main_page.dart';
import 'package:psaltir/providers/bookmarks_provider.dart';
import 'package:psaltir/providers/navigation_provider.dart';
import 'package:psaltir/providers/reading_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<PsalmLoader>(create: (_) => PsalmLoader()),
        ChangeNotifierProvider(
          create: (context) =>
              ReadingProvider(psalmLoader: context.read<PsalmLoader>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              BookmarksProvider(psalmLoader: context.read<PsalmLoader>()),
        ),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ), //TEMPORARY THEME
      ),
    );
  }
}
