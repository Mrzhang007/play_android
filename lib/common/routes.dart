/*
 * @Author: zhangzhong
 * @Date: 2021-09-13 14:34:21
 * @LastEditors: zhangzhong
 * @LastEditTime: 2021-09-15 10:43:59
 * @Description: Do not edit
 * @FilePath: /play_android/lib/common/routes.dart
 */
import 'package:flutter/material.dart';

import 'package:play_android/home/home.dart';
import 'package:play_android/home/home_detail.dart';
import 'package:play_android/auth/register.dart';
import 'package:play_android/auth/login.dart';
import 'package:play_android/mine/mine.dart';
import 'package:play_android/system/system.dart';
import 'package:play_android/system/system_article_list.dart';

class RouteName {
  static const String home = 'home';
  static const String homeDetail = 'homeDetail';
  static const String register = 'register';
  static const String login = 'login';
  static const String system = 'system';
  static const String systemArticleList = 'systemArticleList';
  static const String mine = 'mine';
}

Map<String, WidgetBuilder> routes(BuildContext context) {
  return {
    RouteName.home: (context) => Home(),
    RouteName.homeDetail: (context) {
      Map<String, dynamic> args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      return HomeDetail(
        url: args['url'],
        title: args['title'],
      );
    },
    RouteName.register: (context) => Register(),
    RouteName.login: (context) => Login(),
    RouteName.system: (context) => System(),
    RouteName.systemArticleList: (context) {
      Map<String, dynamic> args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      return SystemArticleList(
        id: args['id'],
        name: args['name'],
      );
    },
    RouteName.mine: (context) => Mine(),
  };
}
