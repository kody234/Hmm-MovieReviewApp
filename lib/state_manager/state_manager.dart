import 'package:flutter/cupertino.dart';

class StateManager extends ChangeNotifier {
  int selectedIndex = 0;

  void onSelected(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
