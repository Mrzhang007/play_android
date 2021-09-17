import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();
/// 登录event
class UserLoggedInEvent {
  Map userInfo;

  UserLoggedInEvent(this.userInfo);
}
/// 退出登录event
class UserLogoutEvent {
  UserLogoutEvent();
}
