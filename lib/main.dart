import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';

import 'package:play_android/bottom_navigation/bottom_navigation.dart';
import 'package:play_android/common/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        title: 'Play Android',
        theme: ThemeData(
          primaryColor: Colors.red,
          buttonTheme: ButtonThemeData(
            minWidth: 0,
            height: 0,
            padding: EdgeInsets.all(0),
            buttonColor: Colors.transparent,
          ),
        ),
        home: BottomNavigation(),
        routes: routes(context),
        navigatorObservers: [
          BotToastNavigatorObserver()
        ], //2.registered route observer
        onGenerateRoute: (RouteSettings setting) {
          // 生成钩子、当跳转到routes未定义的命名路由是会invoke这个方法
          print('------------------>>');
          return null;
        },
      ),
    );
  }
}
