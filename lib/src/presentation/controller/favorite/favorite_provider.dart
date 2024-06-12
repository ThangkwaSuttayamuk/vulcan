import 'package:flutter_application_1/src/presentation/controller/favorite/favorite_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite/favorite_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider =
    StateNotifierProvider.autoDispose<FavoriteNotifier, FavoriteState>((ref) {
  return FavoriteNotifier();
});
