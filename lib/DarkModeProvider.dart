/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/21
///     @desc   :
///     version : 1.0
/// </pre>

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/Zhihu/Log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvider with ChangeNotifier {
  /// 深色模式 0: 关闭 1: 开启 2: 随系统
   int _darkMode = 0;

   int get darkMode => _darkMode;

  SharedPreferences prefs;

  DarkModeProvider() {
    init();
  }

  void changeMode(int darkMode) async {
    prefs = await SharedPreferences.getInstance();

    prefs.setInt("DARKMODE", darkMode);
    _darkMode = prefs.getInt("DARKMODE");
    if (darkMode == 1) {
      prefs.setBool("ISDARK", true);
    } else {
      prefs.setBool("ISDARK", false);
    }
    notifyListeners();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();

    var setInt = prefs.getInt("DARKMODE");
    if (setInt != null) {
      _darkMode = prefs.getInt("DARKMODE");
    }
    Log.d("setInt$setInt");
  }
}
