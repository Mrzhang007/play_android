import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class HomeDetail extends StatelessWidget {
  HomeDetail({Key key, @required this.url, @required this.title})
      : super(key: key);

  /// 需要加载的url
  final String url;

  /// 文章标题
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: this.url,
      ),
    );
  }
}
