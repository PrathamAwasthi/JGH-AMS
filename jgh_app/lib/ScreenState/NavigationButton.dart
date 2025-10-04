import 'package:flutter/material.dart';


class NavigationButton with ChangeNotifier{
  int index = 1;

  void homeButton(){
    index = 1;
    notifyListeners();
  }
  void survey(){
    index = 2;
    notifyListeners();
  }
  void installation(){
    index = 3;
    notifyListeners();
  }
  void payment(){
    index = 4;
    notifyListeners();
  }
  void profile(){
    index = 5;
    notifyListeners();
  }
}