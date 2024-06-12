import 'package:flutter_application_1/src/domain/entities/cart.dart';
import 'package:flutter_application_1/src/domain/entities/food.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'food_db.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE foods (
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            ingredients TEXT,
            price REAL,
            image TEXT
          )
        ''');

        db.execute('''
          CREATE TABLE cart (
            id INTEGER PRIMARY KEY,
            food_id INTEGER,
            quantity INTEGER,
            FOREIGN KEY (food_id) REFERENCES foods(id)
          )
        ''');

        db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            food_id INTEGER,
            FOREIGN KEY (food_id) REFERENCES foods(id)
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertFood(Food food) async {
    final db = await database;
    await db.insert('foods', food.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertMultipleFoods(List<Food> foods) async {
    final db = await database;
    Batch batch = db.batch();
    foods.forEach((food) {
      batch.insert('foods', food.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
    await batch.commit(noResult: true);
  }

  Future<List<Food>> getFoods() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('foods');
    return List.generate(maps.length, (i) {
      return Food.fromMap(maps[i]);
    });
  }

  Future<List<Cart>> getCart() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return List.generate(maps.length, (i) {
      return Cart.fromMap(maps[i]);
    });
  }

  Future<Food> getFoodById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'foods',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Food.fromMap(maps.first);
    } else {
      throw Exception('Food not found');
    }
  }

  Future<List<Food>> getAllFavorites() async {
    final dbHelper = DatabaseHelper();
    final favoritesMapList = await dbHelper.getFavorites();
    List<Food> favoritesList = [];
    for (var favoriteMap in favoritesMapList) {
      final foodId = favoriteMap['food_id'] as int;
      final food = await dbHelper.getFoodById(foodId);
      favoritesList.add(food);
    }
    return favoritesList;
  }

  // Future<List<Cart>> getAllCartFoods() async {
  //   final dbHelper = DatabaseHelper();
  //   final cartMapList = await dbHelper.getCart();
  //   List<Cart> cartList = [];
  //   for (var cartMap in cartMapList) {
  //     final foodId = cartMap['food_id'] as int;
  //     final food = await dbHelper.getFoodById(foodId);
  //   }
  //   return cartList;
  // }

  Future<void> addToCart(int foodId, int quantity) async {
    final db = await database;
    final result = await db.query(
      'cart',
      where: 'food_id = ?',
      whereArgs: [foodId],
    );
    result.isNotEmpty
        ? null
        : await db.insert('cart', {'food_id': foodId, 'quantity': quantity});
    ;
    // await db.insert('cart', {'food_id': foodId, 'quantity': quantity});
  }

  Future<bool> isFavorite(int foodId) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'food_id = ?',
      whereArgs: [foodId],
    );
    return result.isNotEmpty;
  }

  Future<void> addToFavorites(int foodId) async {
    final db = await database;
    await db.insert(
      'favorites',
      {'food_id': foodId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> removeFavorite(int foodId) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'food_id = ?',
      whereArgs: [foodId],
    );
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query('favorites');
  }
}
