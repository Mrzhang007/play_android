import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class HomeDetail extends StatelessWidget {
  HomeDetail({Key key, this.url}) : super(key: key);

  /// 需要加载的url
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网页'),
      ),
      body: WebView(
        initialUrl: this.url,
      ),
    );
  }
}