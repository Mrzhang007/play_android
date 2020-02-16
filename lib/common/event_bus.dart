import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class UserLoggedInEvent {
  Map userInfo;

  UserLoggedInEvent(this.userInfo);
}