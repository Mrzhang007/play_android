import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:play_android/common/index.dart';

class Login extends StatefulWidget {
  /// 登录成功是否需要跳转 我的页面
  final bool loginPushMinePage;

  Login({Key? key, this.loginPushMinePage = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _pwdFocusNode = FocusNode();
  // FocusScopeNode _focusScopeNode;

  String _pwd = '';
  TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Global.isLogin) {
      _userNameController.text = Global.user.username;
    }
  }

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
                    controller: _userNameController,
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
                          child: ElevatedButton(
                            style: new ButtonStyle(
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
                            ),
                          ),
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
    if (_userNameController.text == '') {
      BotToast.showText(text: '请输入用户名', align: Alignment.center);
      return;
    }
    if (_pwd == '') {
      BotToast.showText(text: '请输入密码', align: Alignment.center);
      return;
    }
    _userNameFocusNode.unfocus();
    _pwdFocusNode.unfocus();
    Map<String, String> params = {
      'username': _userNameController.text,
      'password': _pwd,
    };
    BotToast.showLoading();
    HttpResp resp = await HttpUtlis.post(Api.login, params: params);
    if (resp.data != null) {
      BotToast.closeAllLoading();
      BotToast.showText(text: '登录成功！', align: Alignment.center);
      Map userInfo = resp.data;
      _storageUserInfo(userInfo, _pwd);
    }
  }

  void _storageUserInfo(Map userInfo, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KString.userInfoKey, jsonEncode(userInfo));
    prefs.setString(KString.passwordKey, password);
    // 存储一下全局信息
    Global.init().then((e) {
      // 刷新首页数据
      eventBus.fire(UserLoggedInEvent(userInfo));
      if (widget.loginPushMinePage) {
        Navigator.pop(context, true);
      }else{
        Navigator.pop(context);
      }
    });
  }
}
