/*
 * @Author: zhangzhong
 * @Date: 2021-09-13 14:34:21
 * @LastEditors: zhangzhong
 * @LastEditTime: 2021-09-14 10:08:29
 * @Description: Do not edit
 * @FilePath: /play_android/lib/common/global.dart
 */
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:play_android/auth/model/user.dart';
import 'package:play_android/common/index.dart';

class Global {
  static late SharedPreferences _prefs; //late 延迟初始化
  static User user = User();
  static bool isLogin = false;
  static String password = '';

  static Future init() async {
    try {

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      print('用户信息-------->>>');

      // _prefs = await SharedPreferences.getInstance();
      // print('用户信息-------->>>$_prefs');
      // var userInfoStr = _prefs.getString(KString.userInfoKey);
      // print('用户信息-------->>>$userInfoStr');
      // if (userInfoStr != null) {
      //   try {
      //     Map<String, dynamic> userInfo =
      //         jsonDecode(userInfoStr) as Map<String, dynamic>;
      //     user = User.fromJson(userInfo);
      //     isLogin = true;
      //   } catch (e) {
      //     print('global init error$e');
      //     isLogin = false;
      //   }
      // } else {
      //   isLogin = false;
      // }
      // // 密码
      // var pwd = _prefs.getString(KString.passwordKey);
      // if (pwd != null) password = pwd;
    } catch (error) {
      print('global init error_Future_$error');
    }
  }
}
