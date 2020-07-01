import 'package:flutter/material.dart';

class GHWCounterViewModel extends ChangeNotifier {
  int _counter  = 100;

  // command + n 快捷键可以生产 get & set 等方法
  int get counter => _counter;

  set counter(int value) {
    _counter = value;
    notifyListeners();
  }


}