import 'package:flutter/material.dart';
import 'package:flutterapplicationdemo/State/user_info_model.dart';

class GHWUserViewModel extends ChangeNotifier {
  UserInfo _user;
  GHWUserViewModel(this._user);

  UserInfo get user => _user;

  set user(UserInfo value) {
    _user = value;
    notifyListeners();
  }

}