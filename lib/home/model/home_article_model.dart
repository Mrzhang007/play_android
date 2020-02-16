class HomeArticleModel {
  /// 分享人
  final String shareUser;

  /// 分享时间
  final String niceShareDate;

  /// 文章标题
  final String title;

  /// 是否收藏
  bool collect;

  /// 链接
  final String link;

  /// 是否置顶  1 置顶  0不置顶
  final int type;

  /// 是否标记 新 tag
  final bool fresh;

  /// 作者
  final String author;

  /// 文章的id
  final int id;

  HomeArticleModel({
    this.shareUser,
    this.niceShareDate,
    this.title,
    this.collect,
    this.link,
    this.type,
    this.fresh,
    this.author,
    this.id,
  });

  HomeArticleModel.fromJson(Map<String, dynamic> json)
      : shareUser = json['shareUser'],
        niceShareDate = json['niceShareDate'],
        title = json['title'],
        collect = json['collect'],
        link = json['link'],
        type = json['type'],
        fresh = json['fresh'],
        author = json['author'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    return {
      'shareUser': shareUser,
      'niceShareDate': niceShareDate,
      'title': title,
      'collect': collect,
      'link': link,
      'type': type,
      'fresh': fresh,
      'author': author,
      'id': id,
    };
  }

  static List<HomeArticleModel> objectArrayWithKeyValuesArray(
      List<dynamic> jsonList) {
    List<HomeArticleModel> modelList = [];
    for (var i = 0; i < jsonList.length; i++) {
      HomeArticleModel model = HomeArticleModel.fromJson(jsonList[i]);
      modelList.add(model);
    }
    return modelList;
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
