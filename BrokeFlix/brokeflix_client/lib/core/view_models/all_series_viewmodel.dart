
import 'package:stacked/stacked.dart';

class AllSeriesViewModel extends BaseViewModel {
  bool isSelected = false;

  void changeSelected() {
    isSelected = !isSelected;
    notifyListeners();
  }
}