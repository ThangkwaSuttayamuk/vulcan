import 'package:flutter_application_1/src/data/datasources/local/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/food_entity.dart';
import '../../domain/repositories/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final DatabaseHelper databaseHelper;

  FoodRepositoryImpl(this.databaseHelper);

  @override
  Future<void> insertFood(FoodEntity food) async {
    final db = await databaseHelper.database;
    await db.insert('foods', food.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> insertMultipleFoods(List<FoodEntity> foods) async {
    final db = await databaseHelper.database;
    Batch batch = db.batch();
    for (var food in foods) {
      batch.insert('foods', food.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<FoodEntity>> getFoods() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('foods');
    return List.generate(maps.length, (i) {
      return FoodEntity.fromMap(maps[i]);
    });
  }

  @override
  Future<FoodEntity> getFoodById(int id) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'foods',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return FoodEntity.fromMap(maps.first);
    } else {
      throw Exception('Food not found');
    }
  }

  @override
  Future<List<FoodEntity>> getAllFavorites() async {
    final db = await databaseHelper.database;
    final favoritesMapList = await db.query('favorites');
    List<FoodEntity> favoritesList = [];
    for (var favoriteMap in favoritesMapList) {
      final foodId = favoriteMap['food_id'] as int;
      final food = await getFoodById(foodId);
      favoritesList.add(food);
    }
    return favoritesList;
  }

  @override
  Future<void> addToFavorites(int foodId) async {
    final db = await databaseHelper.database;
    await db.insert('favorites', {'food_id': foodId},
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<void> addToUserFavorite(int userId, int foodId) async {
    final db = await databaseHelper.database;
    await db.insert(
      'favorites',
      {
        'user_id': userId,
        'food_id': foodId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavorite(int foodId) async {
    final db = await databaseHelper.database;
    await db.delete('favorites', where: 'food_id = ?', whereArgs: [foodId]);
  }

  @override
  Future<void> removeUserFavorite(int userId, int foodId) async {
    final db = await databaseHelper.database;
    await db.delete(
      'favorites',
      where: 'user_id = ? AND food_id = ?',
      whereArgs: [userId, foodId],
    );
  }

  @override
  Future<bool> isFavorite(int foodId) async {
    final db = await databaseHelper.database;
    final result =
        await db.query('favorites', where: 'food_id = ?', whereArgs: [foodId]);
    return result.isNotEmpty;
  }
}
