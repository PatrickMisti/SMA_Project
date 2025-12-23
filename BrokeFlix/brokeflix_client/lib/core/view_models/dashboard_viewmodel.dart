


import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends BaseViewModel {
  PageController pageController;
  int _currentIndex = 0;

  DashboardViewModel(): pageController = PageController(initialPage: 0);


  int get currentIndex => _currentIndex;

  ValueChanged<int>? get updateCurrentIndex => (int index) {
    _currentIndex = index;
    pageController.jumpToPage(_currentIndex);
    notifyListeners();
  };
}