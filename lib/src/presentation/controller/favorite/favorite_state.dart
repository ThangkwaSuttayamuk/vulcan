class FavoriteState {
  final bool isFavorite;
  
  FavoriteState({required this.isFavorite});

  FavoriteState copyWith({bool? isFavorite}) {
    return FavoriteState(isFavorite: isFavorite ?? this.isFavorite);
  }

}
