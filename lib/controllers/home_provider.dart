import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool isShowMap = false;

  void changeTab() {
    isShowMap = !isShowMap;
    notifyListeners();
  }
  
}