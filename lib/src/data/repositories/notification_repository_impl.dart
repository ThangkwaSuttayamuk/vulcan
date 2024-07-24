import 'package:flutter_application_1/src/data/datasources/local/database_helper.dart';
import 'package:flutter_application_1/src/domain/entities/notification_entity.dart';
import 'package:flutter_application_1/src/domain/entities/order_entity.dart';
import 'package:flutter_application_1/src/domain/entities/order_item_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/notification_repository.dart';
import 'package:flutter_application_1/src/domain/repositories/order_repository.dart';
import 'package:sqflite/sqflite.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final DatabaseHelper databaseHelper;

  NotificationRepositoryImpl(this.databaseHelper);

  @override
  Future<int> addNotification(
      String title, String period, String description, String image) async {
    final db = await databaseHelper.database;
    final notification = await db.insert(
        'notification',
        {
          'title': title,
          'period': period,
          'description': description,
          'image': image,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return notification;
  }

  @override
  Future<List<NotificationEntity>> getNotification() async {
    final db = await databaseHelper.database;
    final maps = await db.query('notification');
    return List.generate(maps.length, (i) {
      return NotificationEntity.fromMap(maps[i]);
    });
  }
}
