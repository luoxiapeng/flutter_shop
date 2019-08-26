import 'package:flutter/material.dart';
class CurrentIndexProvide  with ChangeNotifier{
   int currentIndex=0;

  //  改变点击时的索引
   changeIndex(int newIndex){
    currentIndex=newIndex;
    notifyListeners();
  }
}