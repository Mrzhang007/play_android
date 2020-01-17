import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

//TODO: 数据转模型  上拉加载更多 下拉刷新数据
class _HomeState extends State<Home> {
  final _homeUrl = 'https://www.wanandroid.com/article/list/0/json';

  Future _requestData() async {
    try {
      return await Dio().get(_homeUrl);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: _requestData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //请求完成
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            //发生错误
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            Map data = response.data['data'];
            print(data['datas']);
            return ListView(
              children: data['datas']
                  .map<Widget>((e) => ListTile(title: Text(e["title"])))
                  .toList(),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
