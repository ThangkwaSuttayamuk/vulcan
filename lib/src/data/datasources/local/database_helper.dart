import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/domain/entities/user_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/food_entity.dart';

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
    await importData();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'food_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            username TEXT,
            password TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE foods (
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            ingredients TEXT,
            price REAL,
            image TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE cart (
            id INTEGER PRIMARY KEY,
            food_id INTEGER,
            quantity INTEGER,
            FOREIGN KEY (food_id) REFERENCES foods(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            food_id INTEGER,
            FOREIGN KEY (food_id) REFERENCES foods(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            address TEXT,
            tel TEXT,
            order_date TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE order_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            order_id INTEGER,
            food_id INTEGER,
            quantity INTEGER,
            FOREIGN KEY (order_id) REFERENCES orders(id),
            FOREIGN KEY (food_id) REFERENCES foods(id)
          )
        ''');
      },
    );
  }

  Future<void> importData() async {
    String jsonString = await rootBundle.loadString('assets/food.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    List<FoodEntity> foodList = jsonData.map((item) {
      return FoodEntity.fromJson(item);
    }).toList();
    final db = await database;
    Batch batch = db.batch();
    for (var food in foodList) {
      batch.insert('foods', food.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);

    String jsonStringUser = await rootBundle.loadString('assets/user.json');
    List<dynamic> jsonDataUser = jsonDecode(jsonStringUser);
    List<UserEntity> userlist = jsonDataUser.map((item) {
      return UserEntity.fromJson(item);
    }).toList();
    for (var user in userlist) {
      batch.insert('users', user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }
}
