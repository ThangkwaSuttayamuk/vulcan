import 'package:flutter_application_1/src/data/datasources/local/database_helper.dart';
import 'package:flutter_application_1/src/domain/entities/food_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/cart_repository.dart';
import 'package:flutter_application_1/src/domain/usecases/get_food_by_id_usecase.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/cart_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final DatabaseHelper databaseHelper;

  CartRepositoryImpl(this.databaseHelper);

  @override
  Future<void> addToCart(int foodId, int quantity) async {
    final db = await databaseHelper.database;
    final result =
        await db.query('cart', where: 'food_id = ?', whereArgs: [foodId]);
    if (result.isEmpty) {
      await db.insert('cart', {'food_id': foodId, 'quantity': quantity},
          conflictAlgorithm: ConflictAlgorithm.ignore);
    } else {
      await db.rawUpdate('''
        UPDATE cart
        SET quantity = quantity + ?
        WHERE food_id = ?
      ''', [quantity, foodId]);
    }
  }

  @override
  Future<List<CartEntity>> getCart() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT cart.id as cartId, foods.id as foodId, foods.name, foods.description, foods.image, foods.price, cart.quantity 
      FROM cart
      INNER JOIN foods ON cart.food_id = foods.id
    ''');
    return List.generate(result.length, (i) {
      return CartEntity.fromMap(result[i]);
    });
  }

  @override
  Future<void> removeToCart(int foodId) async {
    final db = await databaseHelper.database;
    final result =
        await db.query('cart', where: 'food_id = ?', whereArgs: [foodId]);

    if (result.isNotEmpty) {
      final currentQuantity = result.first['quantity'] as int;
      final newQuantity = currentQuantity - 1;

      if (newQuantity > 0) {
        await db.rawUpdate('''
          UPDATE cart
          SET quantity = ?
          WHERE food_id = ?
        ''', [newQuantity, foodId]);
      } else {
        await db.delete('cart', where: 'food_id = ?', whereArgs: [foodId]);
      }
    }
  }

  
}
