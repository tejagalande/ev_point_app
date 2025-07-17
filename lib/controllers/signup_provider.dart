import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {

  bool _userAggreed = false;

  bool get userAggreed => _userAggreed;

  doAgree(){
    if(!_userAggreed){
      _userAggreed = !_userAggreed;
      notifyListeners();
    }
  }

  
  
}