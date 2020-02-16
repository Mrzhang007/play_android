import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:play_android/auth/model/user.dart';
import 'package:play_android/common/index.dart';

class Global {
  static SharedPreferences _prefs;
  static User user = User();
  static bool isLogin;
  static String password;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var userInfoStr = _prefs.getString(KString.userInfoKey);
    print('用户信息-------->>>$userInfoStr');
    if (userInfoStr != null) {
      try {
        Map userInfo = jsonDecode(userInfoStr);
        user = User.fromJson(userInfo);
        isLogin = true;
      } catch (e) {
        print('global init error$e');
        isLogin = false;
      }
    } else {
      isLogin = false;
    }
    // 密码
    var pwd = _prefs.getString(KString.passwordKey);
    if (pwd != null) password = pwd;
  }
}
