import 'package:flutter_application_1/src/domain/usecases/is_favorite_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite/favorite_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<FavoriteState> {
  final IsFavoriteUsecase isFavoriteUsecase;

  FavoriteNotifier(this.isFavoriteUsecase)
      : super(FavoriteState(isFavorite: false));

  Future<void> checkFavorite(int id) async {
    final isFav = await isFavoriteUsecase(id);
    state = state.copyWith(isFavorite: isFav);
  }

  Future<void> statusFavorite(bool status) async {
    state = state.copyWith(isFavorite: !status);
  }
}
