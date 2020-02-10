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
          ModalRoute.of(context).settings.arguments as Map;
      return HomeDetail(
        url: args['url'],
        title: args['title'],
      );
    },
    'register': (context) => Register(),
    'login': (context) => Login(),
  };
}
