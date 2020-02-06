import 'package:flutter/material.dart';

import 'package:play_android/bottom_navigation/bottom_navigation.dart';
import 'package:play_android/common/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play Android',
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: BottomNavigation(),
      routes: routes(context),
    );
  }
}
