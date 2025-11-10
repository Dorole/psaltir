import 'package:flutter/material.dart';
import 'package:psaltir/models/navigation_models.dart';

class NavigationProvider extends ChangeNotifier {
  AppPage _currentPage = AppPage.home;

  AppPage get currentPage => _currentPage;

  void goTo(AppPage page) {
    _currentPage = page;
    notifyListeners();
  }

  void openReadingPage() {
    _currentPage = AppPage.reading;
    notifyListeners();
  }
}
