import 'package:flutter_application_1/src/presentation/controller/favorite/favorite_state.dart';
import 'package:flutter_application_1/utils/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<FavoriteState> {
  FavoriteNotifier() : super(FavoriteState(isFavorite: false));
  DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> checkFavorite(int id) async {
    final isFav = await dbHelper.isFavorite(id);
    state = state.copyWith(isFavorite: isFav);
  }

  Future<void> statusFavorite(bool status)async{
    state = state.copyWith(isFavorite: !status);
  }
}
