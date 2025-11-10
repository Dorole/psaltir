import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/pages/main_page.dart';
import 'package:psaltir/providers/navigation_provider.dart';
import 'package:psaltir/providers/reading_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReadingProvider()),
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
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainPage());
  }
}
