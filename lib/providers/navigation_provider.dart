import 'package:flutter/material.dart';
import 'package:psaltir/models/navigation_models.dart';

class NavigationProvider extends ChangeNotifier {
  AppPage _currentPage = AppPage.home;
  AppPage _lastPage = AppPage.home;

  AppPage get currentPage => _currentPage;
  AppPage get lastPage => _lastPage;
  bool get lastReading => _lastPage == AppPage.reading;

  void goTo(AppPage page) {
    _lastPage = _currentPage;
    _currentPage = page;
    notifyListeners();
  }

  void openReadingPage() {
    goTo(AppPage.reading);
  }
}
