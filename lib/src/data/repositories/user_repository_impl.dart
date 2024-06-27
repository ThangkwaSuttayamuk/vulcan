import 'package:flutter_application_1/src/data/datasources/local/database_helper.dart';
import 'package:flutter_application_1/src/domain/entities/user_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final DatabaseHelper databaseHelper;

  UserRepositoryImpl(this.databaseHelper);

  @override
  Future<UserEntity> getUser(String username, String password) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    print(maps);

    if (maps.isNotEmpty) {
      return UserEntity.fromMap(maps.first);
    } else {
      throw Exception('User not found');
    }
  }
}
