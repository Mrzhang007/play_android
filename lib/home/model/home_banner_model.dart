class HomeBannerModel {
  /// 描述
  final String desc;

  ///
  final int id;

  ///
  final String imagePath;

  ///
  final int isVisible;

  ///
  final int order;

  ///
  final String title;

  ///
  final int type;

  ///
  final String url;

  HomeBannerModel({
    this.desc = '',
    this.id = 0,
    this.imagePath = '',
    this.isVisible = 0,
    this.order = 0,
    this.title = '',
    this.type = 0,
    this.url = '',
  });

  HomeBannerModel.fromJson(Map<String, dynamic> json)
      : desc = json['desc'],
        id = json['id'],
        imagePath = json['imagePath'],
        isVisible = json['isVisible'],
        order = json['order'],
        title = json['title'],
        type = json['type'],
        url = json['url'];

  Map<String, dynamic> toJson() {
    return {
      'desc': this.desc,
      'id': this.id,
      'imagePath': this.imagePath,
      'isVisible': this.isVisible,
      'order': this.order,
      'title': this.title,
      'type': this.type,
      'url': this.url,
    };
  }

  static List<HomeBannerModel> objectArrayWithKeyValuesArray(
      List<dynamic> jsonList) {
    List<HomeBannerModel> modelList = [];
    for (var i = 0; i < jsonList.length; i++) {
      HomeBannerModel model = HomeBannerModel.fromJson(jsonList[i]);
      modelList.add(model);
    }
    return modelList;
  }
}

/**
 *
 * {
    "desc":"扔物线",
    "id":29,
    "imagePath":"https://wanandroid.com/blogimgs/5d362c2a-2e9e-4448-8ee4-75470c8c7533.png",
    "isVisible":1,
    "order":0,
    "title":"LiveData：还没普及就让我去世？我去你的 Kotlin 协程",
    "type":0,
    "url":"https://url.rengwuxian.com/y3zsb"
    }
*/
