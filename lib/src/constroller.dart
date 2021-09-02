import 'package:flutter/material.dart';

class ProsteDropMenuController extends ChangeNotifier {
  bool isShow = false;
  int selectItem = 0;

  void showMenu(int key) {
    isShow = true;
    selectItem = key;
    notifyListeners();
  }

  void hideMenu() {
    isShow = false;
    notifyListeners();
  }

  void toggleMenu(int key) {
    selectItem = key;
    isShow = !isShow;
    notifyListeners();
  }
}
