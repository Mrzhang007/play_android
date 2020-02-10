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
}
