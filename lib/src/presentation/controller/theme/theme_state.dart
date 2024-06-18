class ThemeState {
  final bool theme;

  ThemeState({
    this.theme = false,
  });

  ThemeState copyWith({bool? theme}) {
    return ThemeState(
      theme: theme ?? this.theme,
    );
  }
}
