import 'package:flutter/material.dart';

import 'package:play_android/common/api.dart';
import 'package:play_android/common/index.dart';
import 'package:play_android/home/model/home_article_model.dart';
import 'package:play_android/home/model/home_banner_model.dart';
import 'package:play_android/home/view/home_banner.dart';
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
  bool get wantKeepAlive => true; // 切换底部Tab时候 保存状态

  ScrollController _controller = ScrollController();
  var _listData = <HomeArticleModel>[];
  int _currentPage = 0;
  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.complete;
  bool _isRefreshing = false;
  var _loginSubscription;
  var _logoutSubscription;
  List<HomeBannerModel> _bannerDataList = []; // banner数据

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
    // 注册eventbus  不加这个的UserLoggedInEvent  就表示订阅所有的事件
    _loginSubscription = eventBus.on<UserLoggedInEvent>().listen((event) {
      print('==========dddd....>>>' + event.toString());
      _onRefresh(); // 刷新首页数据
    });
    _logoutSubscription = eventBus.on<UserLogoutEvent>().listen((event) {
      _onRefresh(); // 刷新首页数据
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 取消订阅
    _loginSubscription.cancel();
    _logoutSubscription.cancel();
  }

  void _onLoadMore() {
    if (_loadMoreStatus == LoadMoreStatus.isLoading) return;
    if (_isRefreshing) return;
    setState(() {
      _loadMoreStatus = LoadMoreStatus.isLoading;
    });
    _loadHomeData(isLoadMore: true);
  }

  Future _loadHomeData({bool isLoadMore = false}) async {
    // 获取banner数据
    HttpResp bannerResp = await HttpUtlis.get(Api.homeBanner);
    if (bannerResp.status == Status.succeed) {
      List data = bannerResp.data;
      _bannerDataList = HomeBannerModel.objectArrayWithKeyValuesArray(data);
    }
    String url = Api.articleList + '$_currentPage/json';
    if (!isLoadMore) {
      HttpResp httpResp = await HttpUtlis.get(Api.articleTop);
      if (httpResp.status == Status.succeed) {
        List data = httpResp.data;
        List<HomeArticleModel> listDate =
            HomeArticleModel.objectArrayWithKeyValuesArray(data);
        _listData.clear(); // 刷新需要清空数据，
        _listData.addAll(listDate);
      }
    }
    HttpResp responseData = await HttpUtlis.get(url);
    if (responseData.status == Status.succeed) {
      Map data = responseData.data;
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
          _loadMoreStatus = LoadMoreStatus.complete;
          _bannerDataList = _bannerDataList;
        });
      } else {
        setState(() {
          _listData.addAll(listDate);
          _bannerDataList = _bannerDataList;
        });
        //下拉刷新之后 更新刷新状态
        _isRefreshing = false;
      }
      _currentPage = ++_currentPage;
    }
  }

  Future _onRefresh() async {
    if (_loadMoreStatus == LoadMoreStatus.isLoading) return;
    if (_isRefreshing) return;
    _isRefreshing = true;
    print('上拉刷新');
    _currentPage = 0;
    await _loadHomeData(); // _onRefresh需要有async和await关键字，没有await，刷新图标立马消失，没有async，刷新图标不会消失
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: _buildCustomScrollView(),
    );
  }

  void _onBannerClick(HomeBannerModel item, int pageIndex) {
    Navigator.pushNamed(context, 'homeDetail', arguments: {
      'url': item.url,
      'title': item.title,
    });
  }

  Widget _buildCustomScrollView() {
    return new CustomScrollView(
      controller: _controller,
      slivers: [
        SliverToBoxAdapter(
          child: HomeBanner(
            bannerDataList: _bannerDataList,
            autoLoop: false,
            bannerClick: _onBannerClick,
          ),
        ),
        // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
        SliverList(
          delegate: SliverChildBuilderDelegate(
            _buildListItem,
            childCount: _listData.length + 1,
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(context, index) {
    if (_listData.length == index) {
      // 显示加载跟多页面
      return Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: CircularProgressIndicator(strokeWidth: 2.0)),
      );
    }
    var item = _listData[index];
    return HomeListItem(
      itemData: item,
      onCollectPressed: () {
        item.collect = !item.collect;
        setState(() {});
      },
    );
    // return ListTile(title: Text('list tile index $index'));
  }
}
