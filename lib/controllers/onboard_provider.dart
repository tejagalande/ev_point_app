import 'package:flutter/material.dart';

class OnboardProvider extends ChangeNotifier{

  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;

  bool get lastPage => _currentPage == 2;

  void updatePage(int index){
    _currentPage  = index;
    notifyListeners();

  }

  void nextPage(){
    if(_currentPage < 2){
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeOut).then((_){
        _currentPage += 1;
      });

    }
    

  }

  void skipPage(){
    if(_currentPage < 3){
      pageController.jumpToPage(2);
    }
  }


  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
    
  }


}