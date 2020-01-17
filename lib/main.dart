import 'package:flutter/material.dart';
import 'tabbar/Tabbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play Android',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Tabbar(),
    );
  }
}
