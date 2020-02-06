import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:play_android/common/api.dart';
import 'package:play_android/home/model/home_article_model.dart';
import 'package:play_android/home/view/home_list_item.dart';
// TODO: 用户登录 首页banner
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

  Dio _dio = Dio();
  ScrollController _controller = ScrollController();
  var _listData = <HomeArticleModel>[];
  int _currentPage = 0;
  LoadMoreStatus _loadMorestatus = LoadMoreStatus.complete;
  bool _isRefreshing = false;

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
    if (_loadMorestatus == LoadMoreStatus.isLoading) return;
    if (_isRefreshing) return;
    setState(() {
      _loadMorestatus = LoadMoreStatus.isLoading;
    });
    _loadHomeData(isLoadMore: true);
  }

  void _loadHomeData({bool isLoadMore = false}) async {
    try {
      String url = Api.articleList + '$_currentPage/json';
      if (!isLoadMore) {
        Response topArticle = await Dio().get(Api.articleTop);
        Map topResponseData = topArticle.data;
        if (topResponseData['errorCode'] == 0) {
          print(topResponseData);
          List data = topResponseData['data'];
          List<HomeArticleModel> listDate =
              HomeArticleModel.objectArrayWithKeyValuesArray(data);
          _listData.addAll(listDate);
        }
      }
      Response response = await Dio().get(url);
      Map responseData = response.data;
      if (responseData['errorCode'] == 0) {
        Map data = responseData['data'];
        List<HomeArticleModel> listDate =
            HomeArticleModel.objectArrayWithKeyValuesArray(data['datas']);
        print('加载的条数：' +
            listDate.length.toString() +
            '当前页：' +
            _currentPage.toString());
        if (isLoadMore) {
          //加载更多
          setState(() {
            _listData.addAll(listDate);
            _loadMorestatus = LoadMoreStatus.complete;
          });
        } else {
          setState(() {
            _listData.addAll(listDate);
          });
          //下拉刷新之后 更新刷新状态
          _isRefreshing = false;
        }
        _currentPage = ++_currentPage;
      } else {
        print('请求错误');
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onRefresh() async {
    if (_loadMorestatus == LoadMoreStatus.isLoading) return;
    if (_isRefreshing) return;
    _isRefreshing = true;
    print('上拉刷新');
    _currentPage = 0;
    _listData.clear(); //刷新需要清空数据，
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
