import 'package:flutter_application_1/src/data/datasources/local/database_helper.dart';
import 'package:flutter_application_1/src/domain/entities/order_entity.dart';
import 'package:flutter_application_1/src/domain/entities/order_item_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/order_repository.dart';
import 'package:sqflite/sqflite.dart';

class OrderRepositoryImpl implements OrderRepository {
  final DatabaseHelper databaseHelper;

  OrderRepositoryImpl(this.databaseHelper);

  @override
  Future<int> addOrder(String address, String tel) async {
    final db = await databaseHelper.database;
    final orderId = await db.insert(
        'orders',
        {
          'address': address,
          'tel': tel,
          'order_date': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return orderId;
  }

  @override
  Future<void> addOrderFromCart(String address, String tel) async {
    final db = await databaseHelper.database;

    final orderId = await addOrder(address, tel);

    final cartItems = await db.query('cart');

    Batch batch = db.batch();
    for (var item in cartItems) {
      batch.insert('order_items', {
        'order_id': orderId,
        'food_id': item['food_id'],
        'quantity': item['quantity'],
      });
    }
    await batch.commit(noResult: true);
    await db.delete('cart');
  }

  @override
  Future<List<OrderEntity>> getOrders() async {
    final db = await databaseHelper.database;
    final maps = await db.query('orders');
    return List.generate(maps.length, (i) {
      return OrderEntity.fromMap(maps[i]);
    });
  }

  @override
  Future<List<OrderItemEntity>> getOrderListById(int id) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT order_items.order_id as orderItemId, order_items.food_id, order_items.quantity,foods.name ,foods.image, foods.price
      FROM orders
      INNER JOIN order_items ON orders.id = order_items.order_id
      INNER JOIN foods ON foods.id = order_items.food_id
      WHERE orders.id = $id
    ''');
    return List.generate(result.length, (i) {
      return OrderItemEntity.fromMap(result[i]);
    });
  }
}
