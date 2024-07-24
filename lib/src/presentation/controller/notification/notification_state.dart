import 'package:flutter_application_1/src/domain/entities/notification_entity.dart';

class NotificationState {
  final List<NotificationEntity>? notificationList;

  NotificationState({
    this.notificationList,
  });

  NotificationState copyWith({
    List<NotificationEntity>? notificationList,
  }) {
    return NotificationState(
        notificationList: notificationList ?? this.notificationList);
  }
}
