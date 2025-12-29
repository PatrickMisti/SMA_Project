import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends BaseViewModel {
  PageController? pageController;
  int _currentIndex = 0;

  DashboardViewModel() {
    pageController = PageController(initialPage: _currentIndex);
  }

  int get currentIndex => _currentIndex;

  updateCurrentIndex(int index) {
    _currentIndex = index;
    pageController?.jumpToPage(_currentIndex);
    notifyListeners();
  }
}
