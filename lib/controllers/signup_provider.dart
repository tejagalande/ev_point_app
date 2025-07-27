import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {

  bool _userAggreed = false;
  String _mobileNumber = "";

  bool get userAggreed => _userAggreed;

  String get mobileNumber => _mobileNumber;

  set setMobileNumber(String newNumber) => _mobileNumber = newNumber;

  doAgree(){
    if(!_userAggreed){
      _userAggreed = !_userAggreed;
      notifyListeners();
    }
  }

  
  
}