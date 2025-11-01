import 'package:flutter/material.dart';

class StationDetailProvider extends ChangeNotifier {

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded ;

  StationDetailProvider() {
    
  }


  expandTile() {
    _isExpanded = !_isExpanded ;
    notifyListeners();
  }
  
}