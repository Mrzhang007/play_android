/// 服务器域名
const String host = 'https://www.wanandroid.com';

class Api {
  /// 首页文章列表
  static const String articleList = '$host/article/list/';

  /// 置顶文章
  static const String articleTop = '$host/article/top/json';

  /// 用户注册
  static const String register = '$host/user/register';

  /// 用户登录
  static const String login = '$host/user/login';

  /// 收藏文字 https://www.wanandroid.com/lg/collect/1165/json   文章id，拼接在链接中。
  static const String collect = '$host/lg/collect/';

  /// 取消收藏   文章id，拼接在链接中。
  static const String unCollect = '$host/lg/uncollect_originId/';

  /// 首页banner  https://www.wanandroid.com/banner/json
  static const String homeBanner = '$host/banner/json';

  /// 退出登录 https://www.wanandroid.com/user/logout/json
  static const String logout = '$host/user/logout/json';
}
