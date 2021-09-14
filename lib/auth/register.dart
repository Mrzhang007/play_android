import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';

import 'package:play_android/common/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _pwdFocusNode = FocusNode();
  FocusNode _rePwdFocusNode = FocusNode();
  // FocusScopeNode _focusScopeNode;

  String _userName = '';
  String _pwd = '';
  String _rePwd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.fromLTRB(25, 10, 25, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new Container(
                      height: 22,
                      width: 22,
                      child: Image(
                        image: AssetImage('images/close.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 48, right: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      '注册帐号',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: KFont.size28,
                      ),
                    ),
                  ),
                  TextField(
                    focusNode: _userNameFocusNode,
                    onChanged: (String value) {
                      _userName = value;
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: "请输入用户名",
                        prefixIcon: Icon(Icons.person)),
                  ),
                  TextField(
                    focusNode: _pwdFocusNode,
                    onChanged: (String value) {
                      _pwd = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "请输入密码",
                        prefixIcon: Icon(Icons.lock)),
                  ),
                  TextField(
                    focusNode: _rePwdFocusNode,
                    onChanged: (String value) {
                      _rePwd = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "确认密码",
                        hintText: "请输入密码",
                        prefixIcon: Icon(Icons.lock)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          height: 40,
                          child: ElevatedButton(
                              style: new ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                ),
                              ),
                              onPressed: _register,
                              child: Text(
                                '注册',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _register() async {
    if (_userName == '') {
      BotToast.showText(text: '请输入用户名', align: Alignment.center);
      return;
    }
    if (_pwd == '') {
      BotToast.showText(text: '请输入密码', align: Alignment.center);
      return;
    }
    if (_rePwd == '') {
      BotToast.showText(text: '请再次输入密码', align: Alignment.center);
      return;
    }
    _userNameFocusNode.unfocus();
    _pwdFocusNode.unfocus();
    _rePwdFocusNode.unfocus();
    Map<String, String> params = {
      'username': _userName,
      'password': _pwd,
      'repassword': _rePwd,
    };
    BotToast.showLoading();

    HttpResp resp = await HttpUtlis.post(Api.register, params: params);
    if (resp.data != null) {
      BotToast.closeAllLoading();
      BotToast.showText(text: '恭喜您，注册成功！', align: Alignment.center);
      Map userInfo = resp.data;
      _storageUserInfo(userInfo, _pwd);
    }
  }

  /// 存储用户数据  刷新首页列表
  void _storageUserInfo(Map userInfo, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KString.userInfoKey, jsonEncode(userInfo));
    prefs.setString(KString.passwordKey, password);
    // 存储一下全局信息
    Global.init().then((e) {
      // 刷新首页数据
      eventBus.fire(UserLoggedInEvent(userInfo));
      Navigator.pop(context);
    });
  }
}

// {data: {admin: false, chapterTops: [], collectIds: [], email: , icon: , id: 43840, nickname: zhangzhong, password: , publicName: zhangzhong, token: , type: 0, username: zhangzhong}, errorCode: 0, errorMsg: }
