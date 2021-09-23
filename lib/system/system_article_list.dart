import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';

import 'package:play_android/common/index.dart';
import 'package:play_android/home/model/home_article_model.dart';
import 'package:play_android/home/view/home_list_item.dart';
import 'package:play_android/common/load_more_status.dart';
import 'package:play_android/widget/loading_more_widget.dart';
import 'package:play_android/widget/none_more_widget.dart';

class SystemArticleList extends StatefulWidget {
  final num id;
  final String name;

  SystemArticleList({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SystemArticleList();
}

class _SystemArticleList extends State<SystemArticleList> {
  num _currentPage = 0;
  List<HomeArticleModel> _articleList = [];
  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.complete;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        // 加载更多
        _onLoadMore();
      }
    });
    _loadData();
  }

  Future<void> _loadData() async {
    String url =
        '${Api.knowledgeArticleList}$_currentPage/json?cid=${widget.id}';
    print(url);
    HttpResp resp = await HttpUtlis.get(url);
    if (resp.status == Status.succeed) {
      Map data = resp.data;
      List<HomeArticleModel> listDate =
          HomeArticleModel.objectArrayWithKeyValuesArray(data['datas']);
      num curPage = data['curPage']; // 当前页
      num pageCount = data['pageCount']; // 总页
      setState(() {
        _currentPage = curPage;
        _articleList.addAll(listDate);
        if (curPage == pageCount) {
          _loadMoreStatus = LoadMoreStatus.noneMore;
        } else {
          _loadMoreStatus = LoadMoreStatus.complete;
        }
      });
    } else {
      setState(() {
        _loadMoreStatus = LoadMoreStatus.complete;
      });
      BotToast.showText(text: KString.commonErrorMsg, align: Alignment.center);
    }
  }

  void _onLoadMore() {
    if (_loadMoreStatus == LoadMoreStatus.isLoading ||
        _loadMoreStatus == LoadMoreStatus.noneMore) return;
    setState(() {
      _loadMoreStatus = LoadMoreStatus.isLoading;
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ListView.separated(
        controller: _controller,
        itemBuilder: _buildListItem,
        separatorBuilder: (context, index) => Divider(),
        itemCount: _articleList.length + 1,
      ),
    );
  }

  Widget _buildListItem(context, index) {
    if (_articleList.length == index) {
      if (_loadMoreStatus == LoadMoreStatus.noneMore) {
        return NoneMoreWidget();
      }
      // 显示加载跟多页面
      return LoadingMoreWidget();
    }
    var item = _articleList[index];
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
