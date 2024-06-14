import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../../domain/entities/food_entity.dart';
import '../../../domain/entities/cart_entity.dart';

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

  Future<void> importFood() async {
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
  }
}
