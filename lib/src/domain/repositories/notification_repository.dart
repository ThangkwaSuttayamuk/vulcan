import 'package:flutter_application_1/src/domain/entities/notification_entity.dart';
import 'package:flutter_application_1/src/domain/entities/order_entity.dart';
import 'package:flutter_application_1/src/domain/entities/order_item_entity.dart';

abstract class NotificationRepository {
  Future<int> addNotification(
      String title, String period, String description, String image);
  Future<List<NotificationEntity>> getNotification();
}
