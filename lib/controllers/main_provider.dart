import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {

  int selectedTab = 0;


  changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }
  
}