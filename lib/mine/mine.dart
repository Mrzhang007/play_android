import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:play_android/common/index.dart';

class Mine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MineState();
  }
}

class _MineState extends State<Mine> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      appBar: new AppBar(
        title: Text('mine'),
      ),
      body: new Center(
        child: ElevatedButton(
          child: new Text('退出登录'),
          onPressed: _logout,
        ),
      ),
    );
  }

  void _logout() async {
    BotToast.showLoading();
    HttpResp resp = await HttpUtlis.get(Api.logout);
    BotToast.cleanAll();
    if (resp.status == Status.succeed) {
      BotToast.showText(text: '退出登录成功', align: Alignment.center);
      _cleanStorage();
    }
  }

  void _cleanStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Global.init().then((value) {
      // 刷新首页数据
      eventBus.fire(UserLogoutEvent());
    });
  }
}
