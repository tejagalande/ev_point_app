import 'package:flutter/material.dart';

class OnboardProvider extends ChangeNotifier {
  final GlobalKey bottomButtonKey = GlobalKey();
  late double subtitleHeight;
  RenderBox? bottomButtonRenderBox;
  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;

  bool get lastPage => _currentPage == 2;

  OnboardProvider() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bottomButtonRenderBox =
          bottomButtonKey.currentContext?.findRenderObject() as RenderBox;
      if (bottomButtonRenderBox != null && bottomButtonRenderBox!.hasSize) {
        debugPrint("bottom buttons widget is rendered");
        subtitleHeight = bottomButtonRenderBox!.size.height;  
        debugPrint("widget position:- X=${bottomButtonRenderBox!.localToGlobal(Offset.zero).dx} Y=${bottomButtonRenderBox!.localToGlobal(Offset.zero).dy}");
        debugPrint("bottom buttons positioned widget height is $subtitleHeight");
        notifyListeners();
      } else {
        debugPrint("bottom buttons widget is not rendered yet....");
      }
    });
  }

  void updatePage(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < 2) {
      pageController
          .nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          )
          .then((_) {
            _currentPage += 1;
          });
    }
  }

  void skipPage() {
    if (_currentPage < 3) {
      pageController.jumpToPage(2);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
