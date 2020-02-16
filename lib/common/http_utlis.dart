import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:play_android/common/index.dart';

enum Status { succeed, failed, error } // 接口请求成功，失败，异常

class HttpResp<T> {
  final T data;
  final dynamic exception;
  final Status status;
  HttpResp({
    this.data,
    this.exception,
    this.status,
  });
}

class HttpUtlis {
  static Dio _dio = Dio();

  /// get请求
  static Future get(String url) async {
    try {
      _addCookies();
      Response response = await _dio.get(url);
      Map<String, dynamic> responseMap = response.data;
      print('GET请求返回数据----------->' + responseMap.toString());
      if (responseMap['errorCode'] == 0) {
        //成功后可能接着请求。所以不closeAllLoading
        return HttpResp(
            data: responseMap['data'], exception: null, status: Status.succeed);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(
            text: responseMap['errorMsg'], align: Alignment.center);
        return HttpResp(data: null, exception: null, status: Status.failed);
      }
    } catch (e) {
      return HttpResp(data: null, exception: e, status: Status.error);
    }
  }

  /// post请求
  static Future post(String url, {Map params}) async {
    try {
      _addCookies();
      Response response = await _dio.post(url, queryParameters: params);
      Map<String, dynamic> responseMap = response.data;
      print('POST请求返回数据----------->' + responseMap.toString());
      if (responseMap['errorCode'] == 0) {
        //成功后可能接着请求。所以不closeAllLoading
        return HttpResp(
            data: responseMap['data'], exception: null, status: Status.succeed);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(
            text: responseMap['errorMsg'], align: Alignment.center);
        return HttpResp(data: null, exception: null, status: Status.failed);
      }
    } catch (e) {
      return HttpResp(data: null, exception: e, status: Status.error);
    }
  }

  static _addCookies() {
    List<Cookie> cookies = [];
    if (Global.isLogin) {
      cookies = [
        Cookie('loginUserName', Global.user.username),
        Cookie('loginUserPassword', Global.password),
      ];
    }
    CookieJar cookieJar = CookieJar();
    cookieJar.saveFromResponse(Uri.parse(host), cookies);
    print(cookieJar.loadForRequest(Uri.parse(host)));
    _dio.interceptors.add(CookieManager(cookieJar));
  }
}
