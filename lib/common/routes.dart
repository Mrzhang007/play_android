import 'package:flutter/material.dart';

import 'package:play_android/home/home.dart';
import 'package:play_android/home/home_detail.dart';

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
    }
  };
}
