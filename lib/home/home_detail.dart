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

// class _HomeDetailState extends State<HomeDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('网页'),
//       ),
//       body: Container(
//         height: 700,
//         width: 400,
//         color: Colors.red,
//         child: WebView(
//           initialUrl: 'https://www.baidu.com/',
//         ),
//       ),
//     );
//   }
// }
