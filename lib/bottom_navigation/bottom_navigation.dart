import 'package:flutter/material.dart';

import 'package:play_android/auth/login.dart';
import 'package:play_android/home/home.dart';
import 'package:play_android/mine/mine.dart';
import 'package:play_android/project/project.dart';
import 'package:play_android/common/index.dart';
import 'package:play_android/system/system.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNavigationState();
  }
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  var _controller = PageController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      if (Global.isLogin) {
        _changeTab(index);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login();
            },
            fullscreenDialog: true,
          ),
        );
      }
    } else {
      _changeTab(index);
    }
  }

  void _changeTab(int index) {
    _controller.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          Home(),
          System(),
          Project(),
          Mine(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: KString.bottom_nav_home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: KString.bottom_nav_knowledge,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: KString.bottom_nav_project,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: KString.bottom_nav_mine,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
