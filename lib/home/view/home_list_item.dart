import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:play_android/auth/login.dart';
import 'package:play_android/common/index.dart';
import 'package:play_android/home/model/home_article_model.dart';

class HomeListItem extends StatelessWidget {
  HomeListItem({
    Key? key,
    required this.itemData,
    required this.onCollectPressed,
  }) : super(key: key);

  final HomeArticleModel itemData;

  final VoidCallback onCollectPressed;

  void _onItemPress(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => HomeDetail(
    //           url: itemData.link,
    //           title: itemData.title,
    //         )));
    Navigator.pushNamed(context, 'homeDetail', arguments: {
      'url': itemData.link,
      'title': itemData.title,
    });
  }

  @override
  Widget build(BuildContext context) {
    String shareUser = itemData.shareUser;
    String niceShareDate = itemData.niceShareDate;
    bool collect = itemData.collect;
    int type = itemData.type;
    String author = itemData.author;
    bool fresh = itemData.fresh;
    return TextButton(
        onPressed: () => _onItemPress(context),
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                        child: Text(itemData.title,
                            maxLines: 2,
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 16,
                            )),
                      ),
                      Row(
                        children: <Widget>[
                          type == 1 ? _tag(context, '置顶') : Text(''),
                          fresh ? _tag(context, '新') : Text(''),
                          Text(type == 1 ? '作者：$author' : '分享人：$shareUser',
                              style: TextStyle(
                                  color: Color(0xFF666666), fontSize: 14)),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text('时间：$niceShareDate',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Color(0xFF666666), fontSize: 14)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (Global.isLogin) {
                      //收藏功能
                      _collect();
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                            fullscreenDialog: true,
                          ));
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: collect
                        ? Theme.of(context).primaryColor
                        : Color(0xFFBFBFBF),
                  ),
                ),
              ],
            )));
  }

  void _collect() async {
    bool collect = itemData.collect;
    String url;
    if (collect) {
      url = Api.uncollect + itemData.id.toString() + '/json';
    } else {
      url = Api.collect + itemData.id.toString() + '/json';
    }
    HttpResp resp = await HttpUtlis.post(url);
    if (resp.status == Status.succeed) {
      if (collect) {
        BotToast.showText(text: '取消收藏成功', align: Alignment.center);
      } else {
        BotToast.showText(text: '收藏成功', align: Alignment.center);
      }
    }
    onCollectPressed();
  }

  Widget _tag(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 11),
      ),
    );
  }
}
