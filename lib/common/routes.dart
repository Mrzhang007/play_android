/*
 * @Author: zhangzhong
 * @Date: 2021-09-13 14:34:21
 * @LastEditors: zhangzhong
 * @LastEditTime: 2021-09-13 15:01:32
 * @Description: Do not edit
 * @FilePath: /play_android/lib/common/routes.dart
 */
import 'package:flutter/material.dart';

import 'package:play_android/home/home.dart';
import 'package:play_android/home/home_detail.dart';
import 'package:play_android/auth/register.dart';
import 'package:play_android/auth/login.dart';

class RouteName {
  static const String home = 'home';
  static const String homeDetail = 'homeDetail';
  static const String register = 'register';
  static const String login = 'login';
}

Map<String, WidgetBuilder> routes(BuildContext context) {
  return {
    'home': (context) => Home(),
    'homeDetail': (context) {
      Map<String, dynamic> args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      return HomeDetail(
        url: args['url'],
        title: args['title'],
      );
    },
    'register': (context) => Register(),
    'login': (context) => Login(),
  };
}
