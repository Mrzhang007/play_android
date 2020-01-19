import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:play_android/home/view/home_list_item.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

enum LoadMoreStatus {
  isLoading,
  complete,
  noneMore,
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; //保存状态
  static const host = 'https://www.wanandroid.com';

  ScrollController _controller = ScrollController();
  var _listData = <dynamic>[];
  int _currentPage = 0;
  LoadMoreStatus _loadMorestatus = LoadMoreStatus.complete;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        // 加载更多
        _onLoadMore();
      }
    });
    _loadHomeData();
  }

  void _onLoadMore() {
    if (_loadMorestatus == LoadMoreStatus.isLoading) {
      return;
    }
    setState(() {
      _loadMorestatus = LoadMoreStatus.isLoading;
    });
    print('加载更多');
  }

  void _loadHomeData({int page = 0}) async {
    try {
      Response response = await Dio().get('$host/article/list/$page/json');
      Map responseData = response.data;
      if (responseData['errorCode'] == 0) {
        Map data = response.data['data'];
        List listDate = data['datas'];
        // print(listDate.length);
        setState(() {
          _listData = listDate;
        });
      } else {
        print('请求错误');
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onRefresh() async {
    _currentPage = 0;
    _listData.clear();
    _loadHomeData();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('首页'),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.separated(
            controller: _controller,
            itemCount: _listData.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (_listData.length == index) {
                if (_loadMorestatus == LoadMoreStatus.isLoading) {
                  // 显示加载跟多页面
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0)),
                  );
                } else {
                  return null;
                }
              }
              var item = _listData[index];
              return HomeListItem(
                itemData: item,
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: .0),
          ),
        ));
  }
}
