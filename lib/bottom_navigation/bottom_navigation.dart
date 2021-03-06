import 'package:flutter/material.dart';

import 'package:play_android/home/home.dart';
import 'package:play_android/project/project.dart';
import 'package:play_android/common/index.dart';

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
          Text('page 1'),
          Project(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(KString.bottom_nav_home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text(KString.bottom_nav_knowledge),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text(KString.bottom_nav_project),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
