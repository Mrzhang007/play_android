import 'package:flutter/material.dart';

class Project extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectState();
  }
}

class _ProjectState extends State<Project> with AutomaticKeepAliveClientMixin {
  int _nummber = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('项目'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('project$_nummber'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('点我'),
        onPressed: () {
          setState(() {
            _nummber = ++_nummber;
          });
        },
      ),
    );
  }
}
