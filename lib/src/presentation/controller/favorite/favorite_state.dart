class FavoriteState {
  final bool isFavorite;

  FavoriteState({this.isFavorite = false});

  FavoriteState copyWith({bool? isFavorite}) {
    return FavoriteState(isFavorite: isFavorite ?? this.isFavorite);
  }
}
