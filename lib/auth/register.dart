import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:play_android/common/index.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  Dio _dio = Dio();

  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _pwdFocusNode = FocusNode();
  FocusNode _rePwdFocusNode = FocusNode();
  // FocusScopeNode _focusScopeNode;

  String _userName;
  String _pwd;
  String _rePwd;

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
                          child: RaisedButton(
                              color: Theme.of(context).primaryColor,
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

  void _register() async {
    if (_userName == null) {
      BotToast.showText(text: '请输入用户名', align: Alignment.center);
      return;
    }
    if (_pwd == null) {
      BotToast.showText(text: '请输入密码', align: Alignment.center);
      return;
    }
    if (_rePwd == null) {
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
    Response response = await _dio.post(Api.register, queryParameters: params);
    print(response.data);
    Map resp = response.data;
    BotToast.closeAllLoading();
    if (resp['errorCode'] == 0) {
      BotToast.showText(text: '恭喜您，注册成功！', align: Alignment.center);
    } else {
      String msg = resp['errorMsg'];
      BotToast.showText(text: msg, align: Alignment.center);
    }
  }
}

// {data: {admin: false, chapterTops: [], collectIds: [], email: , icon: , id: 43840, nickname: zhangzhong, password: , publicName: zhangzhong, token: , type: 0, username: zhangzhong}, errorCode: 0, errorMsg: }