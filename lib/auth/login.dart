import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:play_android/common/index.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  Dio _dio = Dio();

  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _pwdFocusNode = FocusNode();
  // FocusScopeNode _focusScopeNode;

  String _userName;
  String _pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 22, 0),
                  height: 22,
                  width: 22,
                  child: FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Image(
                      image: AssetImage('images/close.png'),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 48, right: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 50),
                    child: Text(
                      '登录',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          height: 40,
                          child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              onPressed: _login,
                              child: Text(
                                '登录',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          height: 40,
                          child: RaisedButton(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
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

  /// 去注册
  void _register() {
    Navigator.pushNamed(context, RouteName.register);
  }

  /// 登录
  void _login() async {
    if (_userName == null) {
      BotToast.showText(text: '请输入用户名', align: Alignment.center);
      return;
    }
    if (_pwd == null) {
      BotToast.showText(text: '请输入密码', align: Alignment.center);
      return;
    }
    _userNameFocusNode.unfocus();
    _pwdFocusNode.unfocus();
    Map<String, String> params = {
      'username': _userName,
      'password': _pwd,
    };
    BotToast.showLoading();
    Response response = await _dio.post(Api.login, queryParameters: params);
    print(response.data);
    Map resp = response.data;
    BotToast.closeAllLoading();
    if (resp['errorCode'] == 0) {
      BotToast.showText(text: '登录成功！', align: Alignment.center);
    } else {
      String msg = resp['errorMsg'];
      BotToast.showText(text: msg, align: Alignment.center);
    }
  }
}
