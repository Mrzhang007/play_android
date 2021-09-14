/*
 * @Author: zhangzhong
 * @Date: 2021-09-13 14:34:21
 * @LastEditors: zhangzhong
 * @LastEditTime: 2021-09-13 15:39:34
 * @Description: Do not edit
 * @FilePath: /play_android/lib/auth/model/user.dart
 */
class User {
  final bool admin;
  final String email;
  final String icon;
  final int id;
  final String nickname;
  final String password;
  final String publicName;
  final String token;
  final int type;
  final String username;
  final List? chapterTops;
  final List? collectIds;

  User({
    this.admin = false,
    this.email = '',
    this.icon = '',
    this.id = 0,
    this.nickname = '',
    this.password = '',
    this.publicName = '',
    this.token = '',
    this.type = 0,
    this.username = '',
    this.chapterTops,
    this.collectIds,
  });

  User.fromJson(Map<String, dynamic> json)
      : admin = json['admin'],
        email = json['email'],
        icon = json['icon'],
        id = json['id'],
        nickname = json['nickname'],
        password = json['password'],
        publicName = json['publicName'],
        token = json['token'],
        type = json['type'],
        username = json['username'],
        chapterTops = json['chapterTops'],
        collectIds = json['collectIds'];

  Map<String, dynamic> toJson() {
    return {
      'admin': admin,
      'email': email,
      'icon': icon,
      'id': id,
      'nickname': nickname,
      'password': password,
      'publicName': publicName,
      'token': token,
      'type': type,
      'username': username,
      'chapterTops': chapterTops,
      'collectIds': collectIds,
    };
  }
}
