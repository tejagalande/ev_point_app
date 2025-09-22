import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool isShowMap = false;
  int currentIndex = 1;
  void changeTab() {
    // isShowMap = !isShowMap;
    currentIndex = currentIndex == 0 ? 1 : 0 ;
    notifyListeners();
  }
  
}