import 'package:flutter/material.dart';

import 'package:play_android/home/home_detail.dart';
import 'package:play_android/home/model/home_article_model.dart';

class HomeListItem extends StatelessWidget {
  HomeListItem({Key key, this.itemData}) : super(key: key);

  final HomeArticleModel itemData;

  void _onItemPress(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeDetail(
              url: itemData.link,
              title: itemData.title,
            )));
  }

  @override
  Widget build(BuildContext context) {
    String shareUser = itemData.shareUser;
    String niceShareDate = itemData.niceShareDate;
    bool collect = itemData.collect;
    return FlatButton(
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
                          Text('分享人：$shareUser',
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
                Icon(
                  Icons.favorite,
                  color: collect
                      ? Theme.of(context).primaryColor
                      : Color(0xFFBFBFBF),
                ),
              ],
            )));
  }
}

/**
 * {
        "apkLink":"",
        "audit":1,
        "author":"",
        "chapterId":502,
        "chapterName":"自助",
        "collect":false,
        "courseId":13,
        "desc":"",
        "envelopePic":"",
        "fresh":false,
        "id":11545,
        "link":"https://juejin.im/post/5e2135b251882521245bb0e8",
        "niceDate":"2天前",
        "niceShareDate":"2天前",
        "origin":"",
        "prefix":"",
        "projectLink":"",
        "publishTime":1579240835000,
        "selfVisible":0,
        "shareDate":1579235694000,
        "shareUser":"rain9155",
        "superChapterId":494,
        "superChapterName":"广场Tab",
        "tags":[

        ],
        "title":"这是一份关于HTTP协议的学习总结",
        "type":0,
        "userId":12884,
        "visible":1,
        "zan":0
    }
 */
